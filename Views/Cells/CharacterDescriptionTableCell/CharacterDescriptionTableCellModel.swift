//
//  CharacterDescriptionTableCellModel.swift
//  Marvel
//
//  Created by Даниил on 26.04.2021.
//

import ReactorKit

class CharacterDescriptionTableCellModel: BaseCellModel, Reactor {
	typealias Action = Void
	
	struct State {
		var characterDescription: String
	}
	

	let initialState: State
	
	init(character: CharacterModel) {
		
		let description = character.characterDescription.replacingOccurrences(of: " ", with: "").isEmpty ? "No description has been provided for this character" : character.characterDescription
		initialState = State(characterDescription: description)
			
		super.init(cellIdentifier: CharacterDescriptionTableCell.cellIdentifier)
	}
}
