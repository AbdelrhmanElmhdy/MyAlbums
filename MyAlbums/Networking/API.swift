//
//  API.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import Foundation
import Moya

enum API {
	case users(id: Int)
	case albums(forUserId: Int)
	case photos(forAlbumId: Int)
}

extension API: TargetType {

	var baseURL: URL {  URL(string: "https://jsonplaceholder.typicode.com")! }

	var path: String {
		switch self {
		case let .users(id): return "/users/\(id)"
		case .albums: return "/albums"
		case .photos: return "/photos"
		}
	}
	
	var method: Moya.Method { .get }
	
	var task: Moya.Task {
		switch self {
		case .users:
			return .requestPlain
		case let .albums(userId):
			return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.default)
		case let .photos(albumId):
			return .requestParameters(parameters: ["albumId": albumId], encoding: URLEncoding.default)
		}
	}
	
	var headers: [String : String]? { ["Content-Type": "application/json"] }
	
	var sampleData: Data {
		switch self {
		case .users:
			return SAMPLE_USER_RESPONSE.data(using: .utf8)!
		case .albums:
			return SAMPLE_USER_ALBUMS_RESPONSE.data(using: .utf8)!
		case .photos:
			return SAMPLE_ALBUM_PHOTOS_RESPONSE.data(using: .utf8)!
		}
	}
	
}

// MARK: Sample Responses

fileprivate let SAMPLE_USER_RESPONSE = #"""
{
"id": 1,
"name": "Leanne Graham",
"username": "Bret",
"email": "Sincere@april.biz",
"address": {
"street": "Kulas Light",
"suite": "Apt. 556",
"city": "Gwenborough",
"zipcode": "92998-3874",
"geo": {
"lat": "-37.3159",
"lng": "81.1496"
}
},
"phone": "1-770-736-8031 x56442",
"website": "hildegard.org",
"company": {
"name": "Romaguera-Crona",
"catchPhrase": "Multi-layered client-server neural-net",
"bs": "harness real-time e-markets"
}
}
"""#

fileprivate let SAMPLE_USER_ALBUMS_RESPONSE = #"""
[
{
"userId": 3,
"id": 21,
"title": "repudiandae voluptatem optio est consequatur rem in temporibus et"
},
{
"userId": 3,
"id": 22,
"title": "et rem non provident vel ut"
},
{
"userId": 3,
"id": 23,
"title": "incidunt quisquam hic adipisci sequi"
},
{
"userId": 3,
"id": 24,
"title": "dolores ut et facere placeat"
}
]
"""#

fileprivate let SAMPLE_ALBUM_PHOTOS_RESPONSE = #"""
[
{
"albumId": 1,
"id": 1,
"title": "accusamus beatae ad facilis cum similique qui sunt",
"url": "https://via.placeholder.com/600/92c952",
"thumbnailUrl": "https://via.placeholder.com/150/92c952"
},
{
"albumId": 1,
"id": 2,
"title": "reprehenderit est deserunt velit ipsam",
"url": "https://via.placeholder.com/600/771796",
"thumbnailUrl": "https://via.placeholder.com/150/771796"
},
{
"albumId": 1,
"id": 3,
"title": "officia porro iure quia iusto qui ipsa ut modi",
"url": "https://via.placeholder.com/600/24f355",
"thumbnailUrl": "https://via.placeholder.com/150/24f355"
}
]
"""#
