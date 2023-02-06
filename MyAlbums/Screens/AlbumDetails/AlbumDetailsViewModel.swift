//
//  AlbumDetailsViewModel.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import Combine

class AlbumDetailsViewModel {
	// MARK: State
	
	@Published var albumID: Int = -1
	@Published var title: String = ""
	@Published var isLoading: Bool = false
	@Published var searchText: String = ""
	
	// MARK: Initialization
	
	init(album: Album) {
		self.albumID = album.id
		self.title = album.title
	}
	
	// MARK: Logic
	
	func fetchImages() {
		
	}
}
