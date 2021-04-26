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
			container.register(Service.self) { r in
				MarvelService(apiManager: APIManager(),
											dbManager: DBManager())
			}.inObjectScope(.container)
		})
	}
}
