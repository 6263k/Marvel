//
//  CharacterCellModel.swift
//  Marvel
//
//  Created by Даниил on 23.04.2021.
//

import ReactorKit

class CharacterCellModel: BaseCellModel, Reactor {

	enum Action {
		case onCellTapped
	}
	
	struct State {
		let characterName: String
		let characterImageURL: URL?
	}
	
	let initialState: State
	
	init(with character: CharacterModel) {
		let characterName = character.name
		let characterImageURL = character.imageURL
		initialState = State(characterName: characterName, characterImageURL: characterImageURL)
		
		super.init(cellIdentifier: CharacterTableViewCell.cellIdentifier)
	}
	
	
}
