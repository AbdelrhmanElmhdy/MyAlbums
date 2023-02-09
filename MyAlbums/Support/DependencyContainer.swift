//
//  DependencyContainer.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import Foundation

class DependencyContainer {
	
	// MARK: Managers
	
	let networkManager = NetworkManagerFactory.make()
	let userDefaultsManager = UserDefaultsManagerFactory.make()
	
	// MARK: Services
	
	lazy var userService = UserService(networkManager: networkManager)
	lazy var albumService = AlbumService(networkManager: networkManager)
	lazy var photoService = PhotoService(networkManager: networkManager)
	lazy var userPreferencesService: UserPreferencesService = UserPreferencesService(userDefaultsManager: userDefaultsManager)
	
}
