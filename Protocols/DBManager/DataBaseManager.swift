//
//  DataBase.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import Foundation
import RealmSwift

protocol DataBaseManager {
	var realm: Realm { get }
	var configuration: Realm.Configuration { get }
	
	init(config: Realm.Configuration)
}
