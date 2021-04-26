//
//  BaseCellModel.swift
//  Marvel
//
//  Created by Даниил on 23.04.2021.
//

import UIKit

class BaseCellModel {
	
	let cellIdentifier : String
	
	init(cellIdentifier: String){
		self.cellIdentifier = cellIdentifier
	}
	
	func cellSize(width: CGFloat = 50.0, height: CGFloat = 50.0) -> CGSize {
		return CGSize(width: width, height: height)
	}
	
	func cellHeight(height: CGFloat = 50.0) -> CGFloat {
		return height
	}
	
	func cellWidth(width: CGFloat = 50.0) -> CGFloat {
		return width
	}
	
}

