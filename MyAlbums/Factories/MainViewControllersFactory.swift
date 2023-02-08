//
//  MainViewControllersFactory.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

class MainViewControllersFactory {
	let dependencyContainer: DependencyContainer
	
	lazy var settingsSectionFactory = SettingsSectionsFactory(
		userPreferences: dependencyContainer.userDefaultsManager.userPreferences
	)

	init(dependencyContainer: DependencyContainer) {
		self.dependencyContainer = dependencyContainer
	}
}

extension MainViewControllersFactory: ProfileViewControllersFactory {

	func makeProfileViewController(for coordinator: ViewingAlbumDetails) -> ProfileViewController {
		let viewModel = ProfileViewModel(userService: dependencyContainer.userService,
																		 albumService: dependencyContainer.albumService)
		return ProfileViewController(coordinator: coordinator, viewModel: viewModel)
	}
	
	func makeAlbumDetailsViewController(for coordinator: ViewingPhoto, album: Album) -> AlbumDetailsViewController {
		let viewModel = AlbumDetailsViewModel(album: album, photoService: dependencyContainer.photoService)
		return AlbumDetailsViewController(coordinator: coordinator, viewModel: viewModel)
	}

}

extension MainViewControllersFactory: SettingsViewControllersFactory {

	func makeSettingsViewController(for coordinator: DisclosingSettings,
																	settingsSections: [SettingsSection]? = nil) -> SettingsViewController {
		
		let viewModel = SettingsViewModel(userPreferencesService: dependencyContainer.userPreferencesService)
		let viewController = SettingsViewController(coordinator: coordinator, viewModel: viewModel)
		
		let settingsSections = settingsSections ?? settingsSectionFactory.createRootSettingsSections(forViewController: viewController)
		
		let dataSource = SettingsDataSource(settingsSections: settingsSections)
		viewController.datasource = dataSource
		
		return viewController
	}

}
