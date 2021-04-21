//
//  MarvelService.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import Foundation


final class MarvelService: Service {
	let dbManager: DataBaseManager
	let apiManager: NetworkManager
	
	init(apiManager: NetworkManager, dbManager: DataBaseManager) {
		self.dbManager = dbManager
		self.apiManager = apiManager
	}
	
}
