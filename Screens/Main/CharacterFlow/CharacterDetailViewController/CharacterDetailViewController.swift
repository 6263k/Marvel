//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Даниил on 25.04.2021.
//

import RxSwift

class CharacterDetailViewController: BaseViewController<CharacterDetailViewModel> {

	@IBOutlet private weak var tableView: UITableView!
	
	override func setupStyle() {
		navigationItem.title = "Character detail"
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 300
	}
	
	override func bind(reactor: CharacterDetailViewModel) {
		//State
		reactor.state.map { $0.cellModels }
			.bind(to: tableView.rx.items) {tableView, index, cellModel in
				let nib = UINib(nibName: cellModel.cellIdentifier, bundle: .main)
				tableView.register(nib, forCellReuseIdentifier: cellModel.cellIdentifier)
				
				guard let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellIdentifier, for: IndexPath(index: index)) as? BaseTableViewCell else { fatalError() }
				
				cell.configure(with: cellModel)
				return cell
			}
			.disposed(by: disposeBag)
		
		//Actions
		reactor.action.onNext(.didLoad)
		
	}
	
}

