//
//  ViewControllersFactory.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import Foundation

protocol ProfileViewControllersFactory: AnyObject {
	func makeProfileViewController(for coordinator: ViewingAlbumDetails) -> ProfileViewController
	func makeAlbumDetailsViewController(for coordinator: ViewingPhoto, album: Album) -> AlbumDetailsViewController
}

protocol SettingsViewControllersFactory: AnyObject {
	// TODO: Define the settingsDisclosureOption type
	func makeSettingsViewController(for coordinator: DisclosingSettings,
																	settingsSections: [Any]?) -> SettingsViewController
}

typealias ViewControllersFactory = ProfileViewControllersFactory & SettingsViewControllersFactory
