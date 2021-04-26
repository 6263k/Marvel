//
//  AppCoordinator.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import UIKit
import Swinject

final class AppCoordinator: Coordinator {
	enum Route {}
	private let window: UIWindow?
	private let container: Container
	
	private let rootNavigationController: UINavigationController = {
		let nc = UINavigationController()
		nc.navigationBar.isHidden = true
		nc.modalPresentationStyle = .fullScreen
		nc.modalTransitionStyle = .crossDissolve
		nc.view.backgroundColor = .red
//		nc.view.backgroundColor = .clear
		return nc
	}()
	
	private var childCoordinators = [Coordinatable]()
	
	init(with window: UIWindow?, container: Container) {
		self.window = window
		self.container = container
	}
	
	func start() {
		window?.rootViewController = rootNavigationController
		window?.makeKeyAndVisible()
		
		let characterCoordinator = CharacterCoordinator(rootNavigationController, container)
		characterCoordinator.start()
		
	}
	
	func route(to route: Route, from: UIViewController?, with transition: Transition) {}
	
}
