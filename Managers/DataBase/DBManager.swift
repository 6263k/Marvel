//
//  DBManager.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import RealmSwift
import RxSwift

final class DBManager: DataBase {
	let realm: Realm
	let configuration: Realm.Configuration
	
	init?(config: Realm.Configuration){
		self.configuration = config
		
		do {
			self.realm = try Realm(configuration: config)
		} catch let error as NSError {
			print("Realm unresolved error has occured\(error.localizedDescription)")
			return nil
		}
	}
	
	convenience init?() {
		var defaultConfiguration: Realm.Configuration {
			let documentsUrl = try! FileManager.default
				.url(for: .documentDirectory, in: .userDomainMask,
						 appropriateFor: nil, create: false)
				.appendingPathComponent("myRealm.realm")
			let objectTypes = [CharacterModel.self]
			return Realm.Configuration.init(fileURL: documentsUrl, schemaVersion: 1, migrationBlock: {_,_ in }, deleteRealmIfMigrationNeeded: false, objectTypes: objectTypes)
		}
		self.init(config: defaultConfiguration)
	}
	
	
	func getOjbectsWithIDs<Element: Object>(ofType type: Element.Type, IDs: [Int]) -> Observable<[Element]> {
		return Observable.of(Array(realm.objects(type).filter("id IN %d", IDs)))
	}
	
	func saveObjects<Element: Object>(objects: [Element]) {
		realm.safeWrite {
			realm.add(objects, update: .modified)
		}
	}
	
}


private extension Realm {
	func safeWrite(_ block: () -> Void) {
		do {
			if !isInWriteTransaction {
				try write(block)
			}
		} catch let error as NSError {
			print("Couldn't write to a database becase of \(error.localizedDescription)")
		}
	}
}
