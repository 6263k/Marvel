//
//  CharacterDescriptionTableCellModel.swift
//  Marvel
//
//  Created by Даниил on 26.04.2021.
//

import UIKit

class CharacterDescriptionTableCellModel: BaseCellModel {

	let characterDescription: String
	
	init(character: CharacterModel) {
		characterDescription = character.characterDescription.isEmpty ? "No description has been provided for this character" : character.characterDescription
			
		super.init(cellIdentifier: CharacterDescriptionTableCell.cellIdentifier)
	}
}
