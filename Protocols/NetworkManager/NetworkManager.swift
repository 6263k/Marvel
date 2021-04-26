//
//  NetworkManager.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//


import Moya
import RxSwift

protocol NetworkManager {
	var provider: MultiMoyaProvider { get }
	var session: Session { get }
	
	func request(_ target: TargetType) -> Single<Result<Data, APIError>>
}
