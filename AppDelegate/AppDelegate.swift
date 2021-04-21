//
//  AppDelegate.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import UIKit
import Swinject

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
	var appCoordinator: AppCoordinator?
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		let container = AppAssembly.assembly()
		window = UIWindow(frame: UIScreen.main.bounds)
		appCoordinator = AppCoordinator(with: window, container: container)
		appCoordinator?.start()
		
		return true
	}



}

