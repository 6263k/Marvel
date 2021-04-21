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
			case .underlying(let error, _):
				if error._code == NSURLErrorTimedOut { return .requestTimedOut }
				return .moyaError
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
				return "Какая-то ошибка из Мои, я не распарсил их ¯\\_(ツ)_/¯"
		}
	}
}
