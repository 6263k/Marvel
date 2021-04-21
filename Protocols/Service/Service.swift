//
//  MarvelService.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import Foundation

protocol HasDBManager {
	var dbManager: DataBaseManager { get }
}

protocol HasAPIManager {
	var apiManager: NetworkManager { get }
}

protocol Service: HasDBManager & HasAPIManager {
	init(apiManager: NetworkManager, dbManager: DataBaseManager)
}

