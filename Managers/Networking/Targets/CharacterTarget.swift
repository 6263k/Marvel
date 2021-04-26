//
//  Character.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import Moya


enum CharacterTarget {
	case characters(offset: Int, nameStartsWith: String = "", limit: Int = 20)
	case characterWith(id: Int)
}


extension CharacterTarget: TargetType {
	var baseURL: URL {
		URL(string: "https://gateway.marvel.com")!
	}
	
	var path: String {
		switch self {
			case .characters:
				return "/v1/public/characters"
			case .characterWith(let id):
				return "/v1/public/characters/" + String(id)
		}
	}
	
	var method: Method {
		switch self {
			case .characterWith, .characters:
				return .get
		}
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var parameters: [String: Any] {
		var params = [String: Any]()		
		switch self {
			case .characters(let offset, let name, let limit):
				params["offset"] = offset
				params["limit"] = limit
				if !name.isEmpty { params["nameStartsWith"] = name }
				params["orderBy"] = "name"
			case .characterWith:
				break
		}
		return params
	}
	
	var task: Task {
		switch self {
			case .characters, .characterWith:
				return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
		}
	}
	
	var headers: [String : String]? {
		["Content-type":"application/json"]
	}
	
	
}
