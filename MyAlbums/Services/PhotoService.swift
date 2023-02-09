//
//  PhotoService.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Combine

class PhotoService: PhotoServiceProtocol {
	private let networkManager: NetworkManagerProtocol
	
	init(networkManager: NetworkManagerProtocol) {
		self.networkManager = networkManager
	}
	
	func fetchPhotos(forAlbumId albumId: Int) -> AnyPublisher<[Photo], NetworkRequestError> {
		networkManager.executeRequest(.photos(forAlbumId: albumId))
	}
	
}


