//
//  APIManager.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import Moya
import RxSwift
import Alamofire
import CryptoKit

final class APIManager: NetworkManager {
	let provider: MultiMoyaProvider
	let session: Session
	
	init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
		configuration.timeoutIntervalForResource = 15 //Seconds
		configuration.timeoutIntervalForRequest = 15
		session = Session(configuration: configuration)
		
		let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
		let plugins: [PluginType] =  [NetworkLoggerPlugin.init(configuration: loggerConfig), APIInterceptorPlugin()]
		
		provider = MultiMoyaProvider(session: session, plugins: plugins)
	}
	
	func request(_ target: TargetType) -> Single<Result<Data, APIError>> {
		return provider.request(MultiTarget(target))
	}
	
}


