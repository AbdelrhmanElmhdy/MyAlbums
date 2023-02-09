//
//  NetworkManagerProtocol.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import Combine

protocol NetworkManagerProtocol: AutoMockable {
	func executeRequest<T: Decodable>(_ target: API) -> AnyPublisher<T, NetworkRequestError>
}
