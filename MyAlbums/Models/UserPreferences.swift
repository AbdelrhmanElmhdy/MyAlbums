//
//  UserPreferences.swift
//  This file was ported over from Connector project https://github.com/AbdelrhmanElmhdy/Connector
//
//  Created by Abdelrhman Elmahdy on 08/12/2022.
//

import Foundation
import UIKit

struct UserPreferences: Codable {
	static let defaultPreferences = UserPreferences(userInterfaceStyle: .unspecified)
	
	// MARK: General Settings Preferences
	var userInterfaceStyle: UIUserInterfaceStyle
	
}

extension UIUserInterfaceStyle: Codable {}
