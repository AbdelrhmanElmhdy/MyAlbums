//
//  User.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import Foundation

struct User: Codable {
	let id: Int
	let name: String
	let address: Address
}

extension User: Equatable {
	static func == (lhs: User, rhs: User) -> Bool {
		lhs.id == rhs.id && lhs.name == rhs.name && lhs.address == rhs.address
	}
}
