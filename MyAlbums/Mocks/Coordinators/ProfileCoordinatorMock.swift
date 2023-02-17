//
//  ProfileStackCoordinatorMock.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

class ProfileStackCoordinatorMock: Coordinator, ViewingAlbumDetails, ViewingPhoto {
	var children = Array<Coordinator>()
	let navigationController = UINavigationController()
	
	func start() {
		
	}
	
	func viewAlbumDetails(_ album: Album) {
		
	}
	
	func viewPhoto(_ photo: Photo, thumbnailImage: UIImage?) {
		
	}
	
}
