//
//  Reachabilty+Rx.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import Foundation


import Alamofire
import RxSwift

extension NetworkReachabilityManager: ReactiveCompatible {}

extension Reactive where Base: NetworkReachabilityManager {
	static var reachable: Observable<Bool>  {
		return Observable.create { observable in
			let reachability: NetworkReachabilityManager? = NetworkReachabilityManager()
			if let reachability  = reachability {
				observable.onNext(reachability.isReachable)
				reachability.startListening { (status) in
					switch status {
						case .reachable:
							observable.onNext(true)
						case .notReachable, .unknown:
							observable.onNext(false)
					}
				}
			} else {
				observable.onNext(false)
			}
			return Disposables.create {
				reachability?.stopListening()
			}
		}
	}
}
