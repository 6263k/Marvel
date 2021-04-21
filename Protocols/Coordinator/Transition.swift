//
//  Transition.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import UIKit

protocol Transition {
	var isAnimated: Bool { get set }
	
	func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?)
	func close(_ viewController: UIViewController, completion: (() -> Void)?)
}
