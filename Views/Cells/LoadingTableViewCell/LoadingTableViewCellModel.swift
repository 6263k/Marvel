//
//  LoadingCellModel.swift
//  Marvel
//
//  Created by Даниил on 26.04.2021.
//

import ReactorKit

class LoadingTableViewCellModel: BaseCellModel, Reactor {
	
	typealias Action = Void
	typealias State = Void
	var initialState: Void = ()
	
	init() {
		super.init(cellIdentifier: LoadingTableViewCell.cellIdentifier)
	}
	
}
