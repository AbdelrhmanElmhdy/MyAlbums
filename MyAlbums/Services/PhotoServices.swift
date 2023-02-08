//
//  PhotoServices.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Combine

class PhotoServices: PhotoServicesProtocol {
	private let networkManager = NetworkManager()
	
	func fetchPhotos(forAlbumId albumId: Int) -> AnyPublisher<[Photo], NetworkRequestError> {
		networkManager.executeRequest(.photos(forAlbumId: albumId))
	}
	
}


