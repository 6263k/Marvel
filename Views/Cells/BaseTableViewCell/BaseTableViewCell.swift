//
//  BaseCollectionViewCell.swift
//  Marvel
//
//  Created by Даниил on 23.04.2021.
//

import ReactorKit

class BaseTableViewCell: UITableViewCell{
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	func configure(with cellModel: BaseCellModel){
	}
	
	
}

extension BaseTableViewCell {
	static var cellIdentifier : String{
		return String(describing: self)
	}
	
}
