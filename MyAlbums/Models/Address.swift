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

extension Address: Equatable {
	static func == (lhs: Address, rhs: Address) -> Bool {
		return
			lhs.street == rhs.street &&
			lhs.suite == rhs.suite &&
			lhs.city == rhs.city &&
			lhs.zipCode == rhs.zipCode
	}
}
