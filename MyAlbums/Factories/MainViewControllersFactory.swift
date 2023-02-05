//
//  MainViewControllersFactory.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import Foundation

class MainViewControllersFactory {
	let dependencyContainer: DependencyContainer

	init(dependencyContainer: DependencyContainer) {
		self.dependencyContainer = dependencyContainer
	}
}

extension MainViewControllersFactory: ProfileViewControllersFactory {

	func makeProfileViewController(for coordinator: ViewingAlbumDetails) -> ProfileViewController {
		// TODO: Implement factory method
		return ProfileViewController()
	}

}

extension MainViewControllersFactory: SettingsViewControllersFactory {

	func makeSettingsViewController(for coordinator: DisclosingSettings,
																	settingsSections: [Any]?) -> SettingsViewController {
		// TODO: Implement factory method
		return SettingsViewController()
	}

}
