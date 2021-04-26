//
//  MarvelPlugin.swift
//  Marvel
//
//  Created by Даниил on 24.04.2021.
//

import Moya
import CryptoKit

final class APIInterceptorPlugin: PluginType {
	func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
		
		let formatter = DateFormatter()
		formatter.dateFormat = "MM-dd-yyyy HH:mm"
		let timestamp = formatter.string(from: Date())
		
		let publicKey = ProcessInfo.processInfo.environment["public_apiKey"] ?? ""
		let privateKey = ProcessInfo.processInfo.environment["private_apiKey"] ?? ""
		
		let hash = Insecure.MD5.hash(data: (timestamp+privateKey+publicKey).data(using: .utf8)!)
			.map { String(format: "%02hhx", $0) }
			.joined()
		
		var urlComponents: URLComponents? = URLComponents(string: request.url?.absoluteString ?? "")
		
		urlComponents?.queryItems?.append(contentsOf: [
			URLQueryItem(name: "ts", value: timestamp),
			URLQueryItem(name: "apikey", value: publicKey),
			URLQueryItem(name: "hash", value: hash)
		])
		
		guard let url = urlComponents?.url else { return request}
		
		return URLRequest(url: url)
	}
}
