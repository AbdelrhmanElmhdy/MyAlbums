//
//  Address.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import Foundation

struct Address {
	let street: String
	let suite: String
	let city: String
	let zipCode: String
}

extension Address: Codable {
	enum CodingKeys: String, CodingKey {
		case street, suite, city, zipCode = "zipcode"
	}
}

extension Address: CustomStringConvertible {
	var description: String { "\(street), \(suite), \(city), \(zipCode)" }
}
