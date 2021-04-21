//
//  Routable.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import Foundation

protocol Routable {
	associatedtype Route
	
	func route(to route: Route, with transition: Transition)
}
