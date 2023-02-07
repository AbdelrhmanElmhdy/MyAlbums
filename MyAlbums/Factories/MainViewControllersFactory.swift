//
//  MainViewControllersFactory.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

class MainViewControllersFactory {
	let dependencyContainer: DependencyContainer

	init(dependencyContainer: DependencyContainer) {
		self.dependencyContainer = dependencyContainer
	}
}

extension MainViewControllersFactory: ProfileViewControllersFactory {

	func makeProfileViewController(for coordinator: ViewingAlbumDetails) -> ProfileViewController {
		let viewModel = ProfileViewModel()
		return ProfileViewController(coordinator: coordinator, viewModel: viewModel)
	}
	
	func makeAlbumDetailsViewController(for coordinator: ViewingPhoto, album: Album) -> AlbumDetailsViewController {
		let viewModel = AlbumDetailsViewModel(album: album)
		return AlbumDetailsViewController(coordinator: coordinator, viewModel: viewModel)
	}

}

extension MainViewControllersFactory: SettingsViewControllersFactory {

	func makeSettingsViewController(for coordinator: DisclosingSettings,
																	settingsSections: [Any]?) -> SettingsViewController {
		// TODO: Implement factory method
		return SettingsViewController()
	}

}
