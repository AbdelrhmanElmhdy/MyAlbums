//
//  TabBarCoordinator.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

class TabBarCoordinator: Coordinator {
	var children = Array<Coordinator>()
	let navigationController: UINavigationController
	let viewControllersFactory: ViewControllersFactory
	var rootTabBarController: RootTabBarController!
	
	init(navigationController: UINavigationController, viewControllersFactory: ViewControllersFactory) {
		self.navigationController = navigationController
		self.viewControllersFactory = viewControllersFactory
		self.rootTabBarController = RootTabBarController(coordinator: self)
	}
	
	func start() {
		let (profileNavigationController, settingsNavigationController) = createNavControllersForTabs()
		
		rootTabBarController.viewControllers = [
			profileNavigationController,
			settingsNavigationController
		]
		
		let profileStackCoordinator = ProfileStackCoordinator(navigationController: profileNavigationController,
																								viewControllersFactory: viewControllersFactory,
																								parentCoordinator: self)
		
		let settingsStackCoordinator = SettingsStackCoordinator(navigationController: settingsNavigationController,
																									viewControllersFactory: viewControllersFactory,
																									parentCoordinator: self)
		
		startChild(profileStackCoordinator)
		startChild(settingsStackCoordinator)
		
		navigationController.pushViewController(rootTabBarController, animated: false)
	}
	
	/// Instantiate and customize a navigation controller for each tab.
	private func createNavControllersForTabs() -> (
		profileNavigationController: UINavigationController,
		settingsNavigationController: UINavigationController
	) {
		let profileNavigationController = UINavigationController()
		profileNavigationController.tabBarItem = UITabBarItem(
			title: .ui.profile,
			image: .userIcon,
			tag: 0
		)
		
		let settingsNavigationController = UINavigationController()
		settingsNavigationController.tabBarItem = UITabBarItem(
			title: .ui.settings,
			image: .gear,
			tag: 1
		)
		
		return (profileNavigationController, settingsNavigationController)
	}
}
