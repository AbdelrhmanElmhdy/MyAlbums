//
//  API.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import Foundation
import Moya

enum API {
	case user(ofId: Int)
	case albums(forUserId: Int)
	case photos(forAlbumId: Int)
}

extension API: TargetType {

	var baseURL: URL {  URL(string: "https://jsonplaceholder.typicode.com")! }

	var path: String {
		switch self {
		case let .user(id): return "/users/\(id)"
		case .albums: return "/albums"
		case .photos: return "/photos"
		}
	}
	
	var method: Moya.Method { .get }
	
	var task: Moya.Task {
		switch self {
		case .user:
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
		case .user: return JSONFileLoader.loadJsonData(fromFile: .files.sampleUserResponse)!
		case .albums: return JSONFileLoader.loadJsonData(fromFile: .files.sampleUserAlbumsResponse)!
		case .photos: return JSONFileLoader.loadJsonData(fromFile: .files.sampleAlbumPhotosResponse)!
		}
	}
	
}
