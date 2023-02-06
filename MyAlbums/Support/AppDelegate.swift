//
//  AppDelegate.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	private(set) static var shared: AppDelegate!
	
	let dependencyContainer = DependencyContainer()
	lazy var viewControllersFactory = MainViewControllersFactory(dependencyContainer: dependencyContainer)

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		Self.shared = self
		return true
	}

}

