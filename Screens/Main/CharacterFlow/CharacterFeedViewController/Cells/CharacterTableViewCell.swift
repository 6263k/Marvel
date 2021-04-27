//
//  CharacterTableCell.swift
//  Marvel
//
//  Created by Даниил on 24.04.2021.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: BaseTableViewCell {

	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var characterImage: UIImageView!
	
	private var cellModel: CharacterCellModel!
	
		override func configure(with cellModel: BaseCellModel) {
			super.configure(with: cellModel)
			guard let characterCellModel = cellModel as? CharacterCellModel else { return }
			self.cellModel = characterCellModel
			
			nameLabel.text = characterCellModel.characterName
			
			characterImage.kf.setImage(with: characterCellModel.characterImageURL)
			characterImage.contentMode = .scaleToFill
			
			let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onCellTapped))
			tapGesture.numberOfTouchesRequired = 1
			
			contentView.addGestureRecognizer(tapGesture)
		}
	
	@objc private func onCellTapped() {
		cellModel.onCellTapped?()
	}
}
