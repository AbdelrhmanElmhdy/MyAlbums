//
//  AlbumServices.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Combine

class AlbumServices: AlbumServicesProtocol {
	private let networkManager = NetworkManager()
	
	func fetchAlbums(forUserId userId: Int) -> AnyPublisher<[Album], NetworkRequestError> {
		networkManager.executeRequest(.albums(forUserId: userId))
	}
}

