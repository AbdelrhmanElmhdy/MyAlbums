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
