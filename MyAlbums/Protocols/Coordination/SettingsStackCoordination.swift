//
//  SettingsStackCoordination.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import Foundation

protocol DisclosingSettings: AnyObject {
	func disclose(_ settingsDisclosureOption: SettingsDisclosureOption)
}
