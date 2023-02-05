//
//  SceneDelegate.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	var tabBarCoordinator: TabBarCoordinator?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		let navigationController = UINavigationController()
		navigationController.navigationBar.prefersLargeTitles = true
		
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		
		let appDelegate = AppDelegate.shared
		
		tabBarCoordinator = TabBarCoordinator(navigationController: navigationController,
																					viewControllersFactory: appDelegate.viewControllersFactory)
		tabBarCoordinator?.start()
	}
	
}
