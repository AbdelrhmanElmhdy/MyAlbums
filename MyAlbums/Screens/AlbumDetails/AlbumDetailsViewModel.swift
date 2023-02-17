//
//  AlbumDetailsViewModel.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import Combine

class AlbumDetailsViewModel {
	private static let placeHolderPhotos = Array(repeating: Photo(id: 0, albumId: 0, title: "", thumbnailUrl: "", url: ""), count: 15)
	private let photoService: PhotoServiceProtocol
	
	private var photosSubscription: AnyCancellable?
	
	// MARK: State
	
	let albumId: Int
	let title: String
	@Published var photos: [Photo] = AlbumDetailsViewModel.placeHolderPhotos
	@Published var isLoading: Bool = false
	@Published var searchText: String = ""
	
	// MARK: Initialization
	
	init(album: Album, photoService: PhotoServiceProtocol) {
		self.albumId = album.id
		self.title = album.title
		self.photoService = photoService
	}
	
	// MARK: Logic
	
	func fetchPhotos() {
		isLoading = true
		
		photosSubscription = photoService.fetchPhotos(forAlbumId: albumId)
			.sink(receiveCompletion: { _ in }, receiveValue: { [weak self] photos in
				self?.photos = photos
				self?.isLoading = false
			})
	}
}
