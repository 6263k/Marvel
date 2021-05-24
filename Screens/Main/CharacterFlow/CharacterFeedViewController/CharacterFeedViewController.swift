//
//  CharacterFeedViewController.swift
//  Marvel
//
//  Created by Даниил on 23.04.2021.
//


import ReactorKit
import RxCocoa

final class CharacterFeedViewController: BaseViewController<CharacterFeedViewModel>, LoadingViewable {
	typealias Reactor = CharacterFeedViewModel

	@IBOutlet private weak var tableView: UITableView!
	
	private let searchController = UISearchController(searchResultsController: nil)
	
	override func setupStyle() {
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search character by name"
		searchController.hidesNavigationBarDuringPresentation = true
		definesPresentationContext = true
		searchController.isActive = false
		
		
		navigationItem.searchController = searchController
		navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
		navigationItem.title = "Characters"
		
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 300
	}
	
	override func bind(reactor: CharacterFeedViewModel) {
		tableView.rx.setDelegate(self)
			.disposed(by: disposeBag)
		
		tableView.rx.keyboardHeight
			.asDriver(onErrorJustReturn: 0)
			.drive(onNext: { [weak self] offset in
				let offset = offset
				self?.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: offset, right: 0)
				if self?.tableView.isNearBottomEdge() ?? false {
					self?.tableView.contentOffset.y += offset
				}
			})
			.disposed(by: disposeBag)
		
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
		
		
		reactor.state.map { $0.isLoadingInitialData }
			.throttle(.milliseconds(500), scheduler: MainScheduler.instance)
			.bind(to: self.rx.isAnimating)
			.disposed(by: disposeBag)
		
		
		//Actions
		tableView.rx.isNearBottomEdge(edgeOffset: 20.0)
			.filter { $0 }
			.map { _ in Reactor.Action.isMoreDataNeeded }
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
		
		searchController.searchBar.rx.text
			.orEmpty
			.throttle(.milliseconds(500), scheduler: MainScheduler.instance)
			.distinctUntilChanged()
			.map { text in Reactor.Action.searchTextChanged(searchText: text)}
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
		
	}
	
}

extension CharacterFeedViewController: UITableViewDelegate {}

