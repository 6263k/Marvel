//
//  CharacterDetailViewModel.swift
//  Marvel
//
//  Created by Даниил on 25.04.2021.
//

import RxSwift

final class CharacterDetailViewModel: BaseViewModel {
	
	private let characterId: Int
	private let service: MarvelService
	private let coordinator: CharacterCoordinator
	
	private var character: CharacterModel!
	private let disposeBag = DisposeBag()
	
	let cellModels = BehaviorSubject<[BaseCellModel]>(value: [])
	
	init(with characterId: Int, service: MarvelService, coordinator: CharacterCoordinator ) {
		self.characterId = characterId
		self.service = service
		self.coordinator = coordinator
		super.init()
	}
	
	override func setupModel() {
		service.fetchCharacterBy(id: characterId)
			.subscribe(onNext: { [weak self] character in
				self?.character = character
				self?.createCellModels()
			})
			.disposed(by: disposeBag)
	}
	
	private func createCellModels() {
		var cellModels = [BaseCellModel]()
		
		let characterCellModel = CharacterCellModel(with: character)
		cellModels.append(characterCellModel)
		
		let characterDescCellModel = CharacterDescriptionTableCellModel(character: character)
		cellModels.append(characterDescCellModel)
		
		self.cellModels.onNext(cellModels)
	}
	
}

