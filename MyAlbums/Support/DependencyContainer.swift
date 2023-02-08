//
//  DependencyContainer.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import Foundation

class DependencyContainer {
	
	// MARK: Managers
	
	lazy var userDefaultsManager = UserDefaultsManagerFactory.make()
	
	// MARK: Services
	
	lazy var userPreferencesService: UserPreferencesService = UserPreferencesService(userDefaultsManager: userDefaultsManager)
	let userService = UserService()
	let albumService = AlbumService()
	let photoService = PhotoService()
	
}
