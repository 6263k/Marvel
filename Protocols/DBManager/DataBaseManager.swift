//
//  DataBase.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import RealmSwift
import RxSwift

protocol DataBaseManager {
	var realm: Realm { get }
	var configuration: Realm.Configuration { get }
	
	init(config: Realm.Configuration)
	
	func getOjbectWith<Element: Object>(ID: Int, ofType type: Element.Type) -> Observable<Element>
	func getObjectsWhere<Element: Object>(nameStartsWith: String, ofType type: Element.Type) -> Observable<[Element]>
	func saveObjects<Element: Object>(objects: [Element])

}
