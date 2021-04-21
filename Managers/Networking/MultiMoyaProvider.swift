//
//  MultiMoyaProvider.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import Moya
import RxSwift
import Alamofire

final class MultiMoyaProvider: MoyaProvider<MultiTarget> {
	typealias Target = MultiTarget
	private let disposeBag = DisposeBag()
	
	override init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
								requestClosure: @escaping RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
								stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
								callbackQueue: DispatchQueue? = .main,
								session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
								plugins: [PluginType] = [],
								trackInflights: Bool = false) {
		
		super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, session: session, plugins: plugins, trackInflights: trackInflights)
		
	}
}

extension MultiMoyaProvider {
	func request(_ target: Target) -> Single<Result<Data, APIError>> {
		return Single.create { [weak self] observable in
			
			let reachability = NetworkReachabilityManager.rx.reachable.subscribe(onNext: { status in
				if !status { observable(.success(.failure(.networkNotAvailable)))}
			})
			
			let task = self?.request(target, progress: nil) { result in
				switch result {
					case .success(let response):
						observable(.success(.success(response.data)))
					case .failure:
						observable(.success(.failure(.requestFailed)))
				}
			}
			return Disposables.create {
				reachability.dispose()
				task?.cancel()
			}
		}
	}
}
