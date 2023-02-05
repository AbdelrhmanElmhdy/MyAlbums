//
//  Address.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import Foundation

struct Address: Codable {
	let street: String
	let suite: String
	let city: String
	let zipCode: String
	let location: Location
	
	enum CodingKeys: String, CodingKey {
		case street
		case suite
		case city
		case location = "geo"
		case zipCode = "zipcode"
	}
}
