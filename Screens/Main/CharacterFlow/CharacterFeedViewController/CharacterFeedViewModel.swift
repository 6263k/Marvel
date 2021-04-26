//
//  CharacterFeedViewModel.swift
//  Marvel
//
//  Created by Даниил on 23.04.2021.
//


import RxSwift
import RxCocoa

typealias VoidBlock = () -> Void

final class CharacterFeedViewModel: BaseViewModel {
	private let service: MarvelService
	private let coordinator: CharacterCoordinator
	
	private let dissposeBag = DisposeBag()
	private let itemsPerPage = 10
	private var currentOffset = 0
	private var filteredCharacters = [CharacterModel]()
	
	let cellModels = BehaviorSubject<[BaseCellModel]>(value: [])
	let searchText = BehaviorRelay<String>(value: "")
	let isLoadingInitialData = BehaviorRelay<Bool>(value: false)
	let shouldLoadMoreData = BehaviorRelay<Bool>(value: false)
	
	private let isLoadingMoreData = BehaviorRelay<Bool>(value: false)
	private var endReached = false
	
	init(service: MarvelService, coordinator: CharacterCoordinator) {
		self.service = service
		self.coordinator = coordinator
		super.init()
	}
	
	override func setupModel() {

		searchText
			.throttle(.milliseconds(500), scheduler: MainScheduler.instance)
			.distinctUntilChanged()
			.flatMap { [weak self] query -> Observable<Result<[CharacterModel], APIError>> in
				guard let self = self,
							query.count >= 3 else { return .just(.success([])) }
				self.currentOffset = 0
				self.endReached = false
				self.isLoadingInitialData.accept(true)
				return self.service.requestCharacters(offset: self.currentOffset, nameStartsWith: query, limit: self.itemsPerPage)
			}
			.subscribe(onNext: { [weak self] result in
				self?.isLoadingInitialData.accept(false)
				switch result {
					case .failure(let error):
						self?.coordinator.showError(error: error)
					case .success(let characters):
						self?.filteredCharacters = characters
						self?.createModels()
				}
			})
			.disposed(by: dissposeBag)
		
		shouldLoadMoreData
			.filter { [weak self] _ in
				guard let self = self else { return false }
				return !self.isLoadingInitialData.value && !self.isLoadingMoreData.value && !self.filteredCharacters.isEmpty && !self.endReached
			}
			.filter { $0 }
			.flatMap { [weak self] _ -> Observable<Result<[CharacterModel], APIError>> in
				guard let self = self else { return .just(.success([]))}
				self.currentOffset += self.itemsPerPage
				self.isLoadingMoreData.accept(true)
				return self.service.requestCharacters(offset: self.currentOffset,
																							nameStartsWith: self.searchText.value,
																							limit: self.itemsPerPage,
																							ignoreDB: true)

			}
			.subscribe(onNext: { [weak self] result in
				self?.isLoadingMoreData.accept(false)
				switch result {
					case .failure(let error):
						self?.coordinator.showError(error: error)
					case .success(let characters):
						self?.endReached = characters.count < self?.itemsPerPage ?? 10
						self?.filteredCharacters.append(contentsOf: characters)
				}
			})
			.disposed(by: dissposeBag)
		
		
		isLoadingMoreData
			.subscribe(onNext: { [weak self] _ in
				self?.createModels()
			})
			.disposed(by: dissposeBag)
	}
	
	
	
	private func createModels() {
		var cellModels = [BaseCellModel]()
		
		for character in filteredCharacters {
			let characterCellModel = CharacterCellModel(with: character)
			characterCellModel.onCellTapped = { [weak self] in
				let transition = PushTransition(isAnimated: true)
				self?.coordinator.route(to: .characterDetail(id: characterCellModel.id), from: nil, with: transition)
			}
			
			cellModels.append(characterCellModel)
		}
		
		if isLoadingMoreData.value {
			cellModels.append(LoadingTableViewCellModel())
		}
		
		self.cellModels.onNext(cellModels)
	}
	
}
