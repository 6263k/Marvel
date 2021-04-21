//
//  AppAssembly.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import Foundation
import Swinject

enum AppAssembly {
	static func assembly() -> Container {
		return Container(registeringClosure: { container in
			container.register(NetworkManager.self) { _ in APIManager() }.inObjectScope(.container)
			container.register(DataBaseManager.self) { _ in DBManager() }.inObjectScope(.container)
			
			container.register(Service.self) { r in
				MarvelService(apiManager: r.resolve(NetworkManager.self)!,
											dbManager: r.resolve(DataBaseManager.self)!)
			}.inObjectScope(.container)
		})
	}
}
