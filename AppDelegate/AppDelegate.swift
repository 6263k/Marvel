//
//  AppDelegate.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
	var appCoordinator: AppCoordinator?
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow(frame: UIScreen.main.bounds)
		appCoordinator = AppCoordinator(with: window)
		appCoordinator?.start()
		
		return true
	}



}

