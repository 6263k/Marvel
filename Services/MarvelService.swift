//
//  MarvelService.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import RxSwift

final class MarvelService: Service {
	let dbManager: DataBaseManager
	let apiManager: NetworkManager
	
	init(apiManager: NetworkManager, dbManager: DataBaseManager) {
		self.dbManager = dbManager
		self.apiManager = apiManager
	}
	
	
	func requestCharacters(offset: Int, nameStartsWith: String, limit: Int, ignoreDB: Bool = false) -> Observable<Result<[CharacterModel], APIError>> {
		return Observable.create { [weak self] observer in
			var dbRequest: Disposable? = nil
			
			if !ignoreDB {
				dbRequest = self?.dbManager.getObjectsWhere(nameStartsWith: nameStartsWith, ofType: CharacterModel.self)
					.subscribe(onNext: { observer.onNext(.success($0)) })
			}
			
			let apiRequest = self?.apiManager.request(CharacterTarget.characters(offset: offset, nameStartsWith: nameStartsWith, limit: limit))
				.asObservable()
				.mapDecodable(from: CharacterDataWrapper.self)
				.unwrapCharacterContainer()
				.do(onNext: {[weak self] result in
					if case .success(let characters) = result {
						self?.dbManager.saveObjects(objects: characters)
					}
				})
				.share(replay: 1)
				.bind(to: observer)

			return Disposables.create {
				apiRequest?.dispose()
				dbRequest?.dispose()
			}
		}
	}
	
	func fetchCharacterBy(id: Int) -> Observable<CharacterModel> {
		return dbManager.getOjbectWith(ID: id, ofType: CharacterModel.self)
	}
	
	
}


fileprivate extension Observable where Element == Result<CharacterDataWrapper, APIError> {
	
	func unwrapCharacterContainer() -> Observable<Result<[CharacterModel], APIError>> {
		return flatMap { result -> Observable<Result<[CharacterModel], APIError>> in
			switch result {
				case .failure(let error):
					return .just(.failure(error))
				case .success(let wrapper):
					if wrapper.code >= 400 {
						return .just(.failure(.requestFailed))
					}
					return .just(.success(wrapper.data.results))
			}
		}
	}
	
}
