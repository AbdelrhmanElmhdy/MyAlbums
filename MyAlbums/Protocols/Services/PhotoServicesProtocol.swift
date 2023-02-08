//
//  PhotoServiceProtocol.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Combine

/// Handles all services related to the `Photo` type
protocol PhotoServiceProtocol {
	func fetchPhotos(forAlbumId: Int) -> AnyPublisher<[Photo], NetworkRequestError>
}
