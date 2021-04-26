//
//  CharacterDescriptionTableCell.swift
//  Marvel
//
//  Created by Даниил on 26.04.2021.
//

import UIKit

class CharacterDescriptionTableCell: BaseTableViewCell {

	@IBOutlet private weak var descriptionLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
    
	override func configure(with cellModel: BaseCellModel) {
		super.configure(with: cellModel)
		guard let descCellModel = cellModel as? CharacterDescriptionTableCellModel else { return }
		
		descriptionLabel.text = descCellModel.characterDescription
		
		contentView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
	}
}
