//
//  BaseViewController.swift
//  Marvel
//
//  Created by Даниил on 23.04.2021.
//

import ReactorKit

class BaseViewController<ViewModel: Reactor>: UIViewController, StoryboardView {
	typealias Reactor = ViewModel
	var disposeBag: DisposeBag = DisposeBag()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupStyle()
	}
	
	func bind(reactor: ViewModel) {}
	func setupStyle() { }
	
	class func createWithStoryboard(_ storyboard: UIStoryboard, with viewModel: ViewModel ) -> BaseViewController? {
		guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? BaseViewController else {
			assertionFailure("Cannot instantiate UIViewController with \(identifier) from Storyboard")
			return nil
		}
		
		viewController.reactor = viewModel
		return viewController
	}
	
	class func createFromNib(with viewModel: ViewModel) -> BaseViewController? {
		guard let viewController = UIViewController(nibName: identifier, bundle: .main) as? BaseViewController else {
			assertionFailure("Cannot instantitate UIViewController with \(identifier) from Nib")
			return nil
		}
		
		viewController.reactor = viewModel
		return viewController
	}
}
