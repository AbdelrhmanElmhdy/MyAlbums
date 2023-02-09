//
//  Album.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import Foundation

struct Album: Codable {
	let id: Int
	let title: String
}

extension Album: Equatable {
	static func == (lhs: Album, rhs: Album) -> Bool {
		lhs.id == rhs.id && lhs.title == rhs.title
	}
}
