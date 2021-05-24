//
//  CharacterTableCell.swift
//  Marvel
//
//  Created by Даниил on 24.04.2021.
//

import ReactorKit
import Kingfisher

class CharacterTableViewCell: BaseTableViewCell, StoryboardView {
	typealias Reactor = CharacterCellModel
	
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var characterImage: UIImageView!
	
	private var cellModel: CharacterCellModel!
	var disposeBag: DisposeBag = DisposeBag()
	
	
		override func configure(with cellModel: BaseCellModel) {
			super.configure(with: cellModel)
			guard let characterCellModel = cellModel as? CharacterCellModel else { return }
			reactor = characterCellModel
			
			characterImage.contentMode = .scaleToFill
		}
	
	func bind(reactor: CharacterCellModel) {
		//State
		reactor.state.map { $0.characterName }
			.bind(to: nameLabel.rx.text)
			.disposed(by: disposeBag)
		
		reactor.state.map { $0.characterImageURL }
			.subscribe(onNext: { [weak self] url in
				self?.characterImage.kf.setImage(with: url)
			})
			.disposed(by: disposeBag)
		
		//Actions
		let tapGesture = UITapGestureRecognizer()
		tapGesture.numberOfTouchesRequired = 1
		contentView.addGestureRecognizer(tapGesture)
		
		tapGesture.rx.event
			.map { _ in Reactor.Action.onCellTapped }
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
	}
	
}
