//
//  CharacterDetailViewModel.swift
//  Marvel
//
//  Created by Даниил on 25.04.2021.
//

import ReactorKit

final class CharacterDetailViewModel: BaseViewModel, Reactor {
	private let service: MarvelService
	
	enum Action {
		case didLoad
	}
	
	enum Mutation {
		case updateCellModels
	}
	
	struct State {
		var cellModels = [BaseCellModel]()
	}
	
	let initialState: State
	private let disposeBag = DisposeBag()
	private let character: CharacterModel
	
	
	init(with character: CharacterModel, service: MarvelService) {
		self.service = service		
		self.character = character

		initialState = State()
		super.init()
	}
	
	func mutate(action: Action) -> Observable<Mutation> {
		switch action {
			case .didLoad:
				return Observable.just(.updateCellModels)
		}
	}
	
	func reduce(state: State, mutation: Mutation) -> State {
		var newState = state
		switch mutation {
			case .updateCellModels:
				newState.cellModels = createCellModels(state: newState)
		}
		return newState
	}
	
	private func createCellModels(state: State) -> [BaseCellModel] {
		var cellModels = [BaseCellModel]()
		
		let characterCellModel = CharacterCellModel(with: character)
		cellModels.append(characterCellModel)
		
		let characterDescCellModel = CharacterDescriptionTableCellModel(character: character)
		cellModels.append(characterDescCellModel)
		
		return cellModels
	}
	
}

