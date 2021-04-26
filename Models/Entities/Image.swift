//
//  Image.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import Foundation

struct Image: Decodable {
	let path: String
	let imageExtension: String
	
	var imageFullPath: String {
		return path + "." + imageExtension
	}
	
	enum ImageCodingKeys: String, CodingKey {
		case path
		case imageExtension = "extension"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: ImageCodingKeys.self)
		path = try container.decode(String.self, forKey: .path)
		imageExtension = try container.decode(String.self, forKey: .imageExtension)
	}
	
}
