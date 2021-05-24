//
//  CharacterDescriptionTableCell.swift
//  Marvel
//
//  Created by Даниил on 26.04.2021.
//

import ReactorKit

class CharacterDescriptionTableCell: BaseTableViewCell, StoryboardView {
	typealias Reactor = CharacterDescriptionTableCellModel

	@IBOutlet private weak var descriptionLabel: UILabel!
	
	var disposeBag: DisposeBag = DisposeBag()
	
	override func configure(with cellModel: BaseCellModel) {
		super.configure(with: cellModel)
		guard let descCellModel = cellModel as? CharacterDescriptionTableCellModel else { return }
		reactor = descCellModel
		
		
		contentView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
	}
	
	func bind(reactor: CharacterDescriptionTableCellModel) {
		reactor.state.map { $0.characterDescription }
			.bind(to: descriptionLabel.rx.text)
			.disposed(by: disposeBag)
	}
}
