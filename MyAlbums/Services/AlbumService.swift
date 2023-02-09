//
//  AlbumService.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Combine

class AlbumService: AlbumServiceProtocol {
	private let networkManager: NetworkManagerProtocol
	
	init(networkManager: NetworkManagerProtocol) {
		self.networkManager = networkManager
	}
	
	func fetchAlbums(forUserId userId: Int) -> AnyPublisher<[Album], NetworkRequestError> {
		networkManager.executeRequest(.albums(forUserId: userId))
	}
}

