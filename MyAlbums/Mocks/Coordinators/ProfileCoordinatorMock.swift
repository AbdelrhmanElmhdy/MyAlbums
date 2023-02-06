//
//  ProfileCoordinatorMock.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

class ProfileCoordinatorMock: Coordinator, ViewingAlbumDetails {
	var children = Array<Coordinator>()
	let navigationController = UINavigationController()
	
	func start() {
		
	}
	
	func viewAlbumDetails(_ album: Album) {
		
	}
	
}
