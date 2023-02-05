//
//  AppDelegate.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	static var shared: AppDelegate { _shared }
	private static var _shared: AppDelegate!
	
	let dependencyContainer = DependencyContainer()
	lazy var viewControllersFactory = MainViewControllersFactory(dependencyContainer: dependencyContainer)

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		Self._shared = self
		return true
	}

}

