//
//  UserPreferencesService.swift
//  This file was ported over from Connector project https://github.com/AbdelrhmanElmhdy/Connector
//
//  Created by Abdelrhman Elmahdy on 08/12/2022.
//

import UIKit

class UserPreferencesService: UserPreferencesServiceProtocol {
	var userDefaultsManager: UserDefaultsManagerProtocol
	
	var userPreferences: UserPreferences
	
	init(userDefaultsManager: UserDefaultsManagerProtocol) {
		self.userDefaultsManager = userDefaultsManager
		self.userPreferences = userDefaultsManager.userPreferences
	}
	
	func updateUserInterfaceStyle(with state: UIUserInterfaceStyle) {
		userPreferences.userInterfaceStyle = state
		saveChanges()
	}
	
	func saveChanges() {
		userDefaultsManager.userPreferences = userPreferences
	}
}
