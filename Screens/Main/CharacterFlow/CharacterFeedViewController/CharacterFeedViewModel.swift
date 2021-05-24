//
//  CharacterFeedViewModel.swift
//  Marvel
//
//  Created by Даниил on 23.04.2021.
//


import ReactorKit
import RxCocoa

typealias VoidBlock = () -> Void

final class CharacterFeedViewModel: BaseViewModel, Reactor {
	
	enum Action {
		case searchTextChanged(searchText: String)
		case isMoreDataNeeded
		
		//Navigation
		case routeToCharacter(character: CharacterModel)
		case showErrorNetwork(error: APIError)
	}
	
	enum Mutation {
		case moreFilteredCharacters(Result<[CharacterModel], APIError>)
		case filteredCharacters(Result<[CharacterModel], APIError >)
		
		case setIsLoadingInitialData(Bool)
		case setIsLoadingMoreData(Bool)
		
		case updateCellModels
		case updateCurrentOffset(value: Int)
		case setEndReached(Bool)
		
	}
	
	struct State {
		var cellModels: [BaseCellModel] = []
		var filteredCharacters: [CharacterModel] = []
		var isLoadingInitialData: Bool = false
		var endReached: Bool = false
		var isLoadingMoreData: Bool = false
		var currentOffset = 0
		var searchTextValue: String = ""
	}
	
	private let service: MarvelService
	private let itemsPerPage = 10
	private let dissposeBag = DisposeBag()
	
	let initialState: State
	
	init(service: MarvelService) {
		self.service = service
		initialState = State()
		super.init()
	}
	
	func mutate(action: Action) -> Observable<Mutation> {
		switch action {
			case .routeToCharacter, .showErrorNetwork:
				return Observable.empty()
				
			case .isMoreDataNeeded:
				guard !currentState.isLoadingMoreData && !currentState.isLoadingInitialData && !currentState.filteredCharacters.isEmpty && !currentState.endReached else { return Observable.empty() }
				
				return Observable.concat([
					Observable.just(.setIsLoadingMoreData(true)),
					
					Observable.just(.updateCellModels),
					
					service.requestCharacters(offset: currentState.currentOffset, nameStartsWith: currentState.searchTextValue, limit: itemsPerPage, ignoreDB: true)
						.map { Mutation.moreFilteredCharacters($0)},
					
					Observable.just(.setIsLoadingMoreData(false)),
					
					Observable.just(.updateCellModels)
				])
				
			case .searchTextChanged(let searchText):
				guard searchText.count >= 3 else {
					return Observable.concat([
						Observable.just(.filteredCharacters(.success([]))),
						Observable.just(.updateCellModels)
					])
				}
				
				return Observable.concat([
					Observable.just(.updateCurrentOffset(value: 0)),
					
					Observable.just(.setEndReached(false)),
					
					Observable.just(.setIsLoadingInitialData(true)),
					
					service.requestCharacters(offset: currentState.currentOffset, nameStartsWith: searchText, limit: itemsPerPage)
						.map {.filteredCharacters($0) },
					
					Observable.just(.setIsLoadingInitialData(false)),
					
					Observable.just(.updateCellModels)
				])
		}
	}
	
	func reduce(state: State, mutation: Mutation) -> State {
		var newState = state
		
		switch mutation {
			case .filteredCharacters(let result):
				switch result {
					case .failure(let error):
						action.onNext(.showErrorNetwork(error: error))
					case .success(let characters):
						newState.filteredCharacters = characters
				}
			
			case .moreFilteredCharacters(let result):
				switch result {
					case .failure(let error):
						action.onNext(.showErrorNetwork(error: error))
					case .success(let characters):
						newState.currentOffset = state.currentOffset + itemsPerPage
						newState.endReached = characters.count < itemsPerPage
						newState.filteredCharacters.append(contentsOf: characters)
				}
				
			case .setEndReached(let bool):
				newState.endReached = bool
				
			case .setIsLoadingInitialData(let bool):
				newState.isLoadingInitialData = bool
			
			case .setIsLoadingMoreData(let bool):
				newState.isLoadingMoreData = bool
			
			case .updateCurrentOffset(let value):
				newState.currentOffset = value
				
			case .updateCellModels:
				newState.cellModels = createModels(state: state)
		}
		
		return newState
	}
	

	private func createModels(state: State) -> [BaseCellModel] {
		var cellModels = [BaseCellModel]()
		
		for character in currentState.filteredCharacters {
			let characterCellModel = CharacterCellModel(with: character)
			
			characterCellModel.action
				.map { _ in Action.routeToCharacter(character: character) }
				.bind(to: action)
				.disposed(by: dissposeBag)
			
			cellModels.append(characterCellModel)
		}
		
		if currentState.isLoadingMoreData {
			cellModels.append(LoadingTableViewCellModel())
		}
		
		return cellModels
	}
	
}
