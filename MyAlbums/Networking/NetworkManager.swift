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
	
	func executeRequest<T: Decodable>(_ target: API) -> AnyPublisher<T, NetworkRequestError> {
		return APIProvider.requestPublisher(target)
			.tryMap { response in
				guard (200...299) ~= response.statusCode else {
					throw NetworkRequestError.httpResponseError(statusCode: response.statusCode)
				}
				
				return response
			}
			.map(\.data)
			.decode(type: T.self, decoder: JSONDecoder())
			.mapError { error in
				if let error = error as? NetworkRequestError {
					return error
				}
				
				if let error = error as? MoyaError {
					return NetworkRequestError(moyaError: error)
				}
								
				return NetworkRequestError(error: error)
			}
			.eraseToAnyPublisher()
	}
}
