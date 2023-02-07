//
//  AlbumServicesProtocol.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Combine

/// Handles all services related to the `Album` type
protocol AlbumServicesProtocol {
	func fetchAlbums(forUserId userId: Int) -> AnyPublisher<[Album], Error>
}
