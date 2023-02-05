//
//  Location.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import Foundation

struct Location: Codable {
	let latitude: String
	let longitude: String
	
	enum CodingKeys: String, CodingKey {
		case latitude = "lat"
		case longitude = "lng"
	}
}
