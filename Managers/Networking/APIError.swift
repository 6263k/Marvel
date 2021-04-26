//
//  APIError.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import Moya

enum APIError: Error {
	case invalidData
	case requestFailed
	case jsonConversationFailed
	case moyaError
	case networkNotAvailable
	case requestTimedOut
	
	static func from(_ error: MoyaError) -> APIError {
		switch error {
			case .jsonMapping(_):
				return .jsonConversationFailed
			case .underlying(let error , _):
				let error = error.asAFError?.underlyingError as NSError? //MoyaError returns wrong error code so i have to cast it like this
				if error?.code == NSURLErrorTimedOut { return .requestTimedOut }
				return .moyaError
			case .statusCode(_):
				return .requestFailed
			default:
				return .moyaError
		}
	}
}

extension APIError {
	public var localizedDescription: String {
		switch self {
			case .invalidData:
				return "Неверные данные"
			case .jsonConversationFailed:
				return "Не удалось переобразовать JSON в объект"
			case .requestFailed:
					return "Не удалось отправить запрос"
			case .networkNotAvailable:
				return "Соединение с интернетом не доступно"
			case .requestTimedOut:
				return "Время ожидания отправки запроса истекло"
			case .moyaError:
				return "Какая-то ошибка, я не до конца распарсил их ¯\\_(ツ)_/¯"
		}
	}
}
