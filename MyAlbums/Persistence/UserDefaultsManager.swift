//
//  UserDefaultsManager.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import Foundation

class UserDefaultsManager: UserDefaultsManagerProtocol {
	private struct Keys {
		static let userPreferences = "USER_PREFERENCES"
	}
	
	@Storage(key: Keys.userPreferences, defaultValue: UserPreferences.defaultPreferences)
	var userPreferences: UserPreferences
}
