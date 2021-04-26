//
//  Character.swift
//  Marvel
//
//  Created by Даниил on 21.04.2021.
//

import Foundation
import RealmSwift

class CharacterModel: Object, Decodable {
	@objc dynamic var id: Int = Int.max
	@objc dynamic var name: String = ""
	@objc dynamic var characterDescription: String = ""
	@objc dynamic var URI: String = ""
	@objc dynamic private var _imageURL: String = ""
	
	var imageURL: URL? {
		get {
			var components = URLComponents(string: _imageURL)
			components?.scheme = "https"
			return components?.url
		}
		set { _imageURL = newValue?.absoluteString ?? ""}
	}
	
	enum RootKeys: String, CodingKey {
		case id, name
		case characterDescription = "description", URI = "resourceURI", _imageURL = "thumbnail"
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: RootKeys.self)
		id = try container.decode(Int.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		characterDescription = try container.decode(String.self, forKey: .characterDescription)
		URI = try container.decode(String.self, forKey: .URI)
		_imageURL = try container.decode(Image.self, forKey: ._imageURL).imageFullPath
		super.init()
	}
	
	required override init() {
		super.init()
	}
	
	override class func primaryKey() -> String? {
		return "id"
	}
	
	override static func indexedProperties() -> [String] {
		return ["name"]
	}

}

struct CharacterDataWrapper: Decodable {
	let code: Int
	let status: String
	let data: CharacterContainer
}

struct CharacterContainer: Decodable {
	let results: [CharacterModel]
}
