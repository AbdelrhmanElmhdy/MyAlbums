//
//  UserDefaultsManagerMock.swift
//  This file was ported over from Connector project https://github.com/AbdelrhmanElmhdy/Connector
//
//  Created by Abdelrhman Elmahdy on 11/12/2022.
//

import Foundation

/// Replaces user defaults persistence with in-memory persistence
class UserDefaultsManagerMock: UserDefaultsManagerProtocol {
	
	var userPreferences = UserPreferences.defaultPreferences
	
}
