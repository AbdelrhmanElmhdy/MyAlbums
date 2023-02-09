//
//  Photo.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Foundation

struct Photo: Codable {
	let id: Int
	let albumId: Int
	let title: String
	let thumbnailUrl: String
	let url: String
}

extension Photo: Equatable {
	static func == (lhs: Photo, rhs: Photo) -> Bool {
		return
			lhs.id == rhs.id &&
			lhs.albumId == rhs.albumId &&
			lhs.title == rhs.title &&
			lhs.thumbnailUrl == rhs.thumbnailUrl &&
			lhs.url == rhs.url
	}
}
