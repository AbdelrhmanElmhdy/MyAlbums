//
//  SettingsCoordinatorMock.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

class SettingsCoordinatorMock: Coordinator, DisclosingSettings {
	var children = Array<Coordinator>()
	let navigationController = UINavigationController()
	
	func start() {
		
	}
	
	func disclose(_ settingsDisclosureOption: Any) {
		
	}
	
}
