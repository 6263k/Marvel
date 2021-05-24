//
//  LoadingTableViewCell.swift
//  Marvel
//
//  Created by Даниил on 26.04.2021.
//

import ReactorKit

class LoadingTableViewCell: BaseTableViewCell, StoryboardView {
	typealias Reactor = LoadingTableViewCellModel
	
	@IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
	
	var disposeBag: DisposeBag = DisposeBag()
    
	override func configure(with cellModel: BaseCellModel) {
		guard let loadingCellModel = cellModel as? LoadingTableViewCellModel else { return }
		reactor = loadingCellModel
		
		loadingIndicator.color = .systemPink
		loadingIndicator.startAnimating()
		contentView.backgroundColor = .clear
	}
	
	func bind(reactor: LoadingTableViewCellModel) {}
	
}
