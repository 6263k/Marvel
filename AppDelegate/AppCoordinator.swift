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
		return nc
	}()
	
	private var childCoordinators = [Coordinatable]()
	
	init(with window: UIWindow?, container: Container) {
		self.window = window
		self.container = container
	}
	
	func start() {
		
	}
	
	func route(to route: Route, with transition: Transition) {}
	
}
