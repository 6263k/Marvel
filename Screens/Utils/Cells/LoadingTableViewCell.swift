//
//  LoadingTableViewCell.swift
//  Marvel
//
//  Created by Даниил on 26.04.2021.
//

import UIKit

class LoadingTableViewCell: BaseTableViewCell {

	@IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
    
	override func configure(with cellModel: BaseCellModel) {
		guard let _ = cellModel as? LoadingTableViewCellModel else { return }
		
		loadingIndicator.color = .systemPink
		loadingIndicator.startAnimating()
		contentView.backgroundColor = .clear
	}
	
}
