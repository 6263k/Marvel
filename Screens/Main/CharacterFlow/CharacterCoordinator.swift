//
//  CharacterCoordinator.swift
//  Marvel
//
//  Created by Даниил on 22.04.2021.
//

import RxSwift
import Swinject

final class CharacterCoordinator: Coordinator {
	
	enum Route {
		case characterFeed
		case characterDetail(character: CharacterModel)
	}
	
	private let parentNavigationController: UINavigationController
	private let service: MarvelService
	private let disposeBag = DisposeBag()
	
	var navigationController: UINavigationController = {
		let nc = UINavigationController()
		nc.modalPresentationStyle = .fullScreen
		nc.modalTransitionStyle = .crossDissolve
		nc.view.backgroundColor = .gray
		
		let navigationBarAppearance = UINavigationBarAppearance()
		navigationBarAppearance.configureWithOpaqueBackground()
		navigationBarAppearance.backgroundColor = .systemGreen
		nc.navigationBar.scrollEdgeAppearance = navigationBarAppearance
		nc.navigationBar.compactAppearance = navigationBarAppearance
		nc.navigationBar.standardAppearance = navigationBarAppearance
		return nc
	}()
	
	init(_ parentNavigationController: UINavigationController, _ container: Container) {
		guard let service = container.resolve(Service.self) as? MarvelService else { fatalError() }
		self.service = service
		self.parentNavigationController = parentNavigationController
	}
	
	func start() {
		navigationController.willMove(toParent: parentNavigationController)
		parentNavigationController.addChild(navigationController)
		parentNavigationController.view.addSubview(navigationController.view)
		navigationController.didMove(toParent: parentNavigationController)
		
		route(to: .characterFeed, with: SetTransition(isAnimated: false))
	}
	
	func route(to route: Route, from: UIViewController? = nil, with transition: Transition) {
		let fromVC = from ?? navigationController
		
		switch route {
			case .characterFeed:
				routeToCharacterFeed(from: fromVC, with: transition)
			case .characterDetail(let character):
				routeToCharacterDetail(from: fromVC, to: character, with: transition)
		}
	}
	
	private func routeToCharacterFeed(from vc: UIViewController, with transition: Transition) {
		let characterFeedViewModel = CharacterFeedViewModel(service: service)
		guard let characterFeedViewController = CharacterFeedViewController.createWithStoryboard(Storyboard.main, with: characterFeedViewModel) else { return }
		
		characterFeedViewModel.action.subscribe(onNext: { [weak self, characterFeedViewController] action in
			
			if case let .routeToCharacter(character) = action {
				let transition = PushTransition(isAnimated: true)
				self?.route(to: .characterDetail(character: character), from: characterFeedViewController, with: transition)
			}
			
			if case let .showErrorNetwork(error) = action {
				self?.showError(error: error)
			}
			
		}).disposed(by: disposeBag)
		
		transition.open(characterFeedViewController, from: vc, completion: nil)
	}
	
	private func routeToCharacterDetail(from vc: UIViewController, to character: CharacterModel,  with transition: Transition) {
		let characterDetailViewModel = CharacterDetailViewModel(with: character, service: service)
		guard let characterDetailViewController = CharacterDetailViewController.createWithStoryboard(Storyboard.main, with: characterDetailViewModel) else { return }
		
		transition.open(characterDetailViewController, from: vc, completion: nil)
	}
	
	func showError(error: APIError) {
		ErrorView.showIn(viewController: navigationController, message: error.localizedDescription)
	}
}
