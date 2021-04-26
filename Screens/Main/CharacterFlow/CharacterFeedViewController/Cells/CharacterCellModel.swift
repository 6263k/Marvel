//
//  CharacterCellModel.swift
//  Marvel
//
//  Created by Даниил on 23.04.2021.
//

import UIKit

class CharacterCellModel: BaseCellModel {
	
	let id: Int
	let characterName: String
	let characterImageURL: URL?
	var onCellTapped: VoidBlock?
	
	init(with character: CharacterModel) {
		self.id = character.id
		self.characterName = character.name
		self.characterImageURL = character.imageURL
		
		super.init(cellIdentifier: CharacterTableViewCell.cellIdentifier)
	}
	
	
}
