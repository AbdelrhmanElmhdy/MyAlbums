//
//  SettingsStackCoordinator.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

class SettingsStackCoordinator: Coordinator, DisclosingSettings {
	var children = Array<Coordinator>()
	let navigationController: UINavigationController
	let viewControllersFactory: ViewControllersFactory
	private let parentCoordinator: Coordinator
	
	init(navigationController: UINavigationController,
			 viewControllersFactory: ViewControllersFactory,
			 parentCoordinator: Coordinator) {
		self.navigationController = navigationController
		self.viewControllersFactory = viewControllersFactory
		self.parentCoordinator = parentCoordinator
	}
	
	func start() {
		let viewController = viewControllersFactory.makeSettingsViewController(for: self, settingsSections: [])
		navigationController.pushViewController(viewController, animated: false)
	}
	
	func disclose(_ settingsDisclosureOption: Any) {
		// TODO: disclose option
	}
}
