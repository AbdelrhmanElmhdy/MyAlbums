//
//  UserPreferencesServiceProtocol.swift
//  This file was ported over from Connector project https://github.com/AbdelrhmanElmhdy/Connector
//
//  Created by Abdelrhman Elmahdy on 08/12/2022.
//

import UIKit

protocol UserPreferencesServiceProtocol: AutoMockable {
	func updateUserInterfaceStyle(with state: UIUserInterfaceStyle)
	func saveChanges()
}
