//
//  NetworkManager.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import Foundation
import Combine
import Moya
import CombineMoya

class NetworkManager {
	private let APIProvider = MoyaProvider<API>()
	
	func executeRequest<T: Decodable>(_ target: API) -> AnyPublisher<T, Error> {
		return APIProvider.requestPublisher(target)
			.tryMap { response in
				guard (200...299) ~= response.statusCode else {
					throw NetworkRequestError.httpResponseError(statusCode: response.statusCode)
				}
				
				return response
			}
			.map(\.data)
			.decode(type: T.self, decoder: JSONDecoder())
			.mapError {
				if let error = $0 as? UserFriendlyError {
					return error
				}
				
				return GenericError.somethingWentWrong(description: "\(type(of: $0)): \($0.localizedDescription)")
			}
			.eraseToAnyPublisher()
	}
}
