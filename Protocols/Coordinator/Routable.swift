//
//  Routable.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import UIKit

protocol Routable {
	associatedtype Route
	
	func route(to route: Route, from: UIViewController?, with transition: Transition)
}
