//
//  NetworkManager.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//


import Moya

protocol NetworkManager {
	var provider: MultiMoyaProvider { get }
	var session: Session { get }
}
