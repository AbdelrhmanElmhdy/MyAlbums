//
//  ViewControllerAndViewModelBinder.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import UIKit
import Combine

class ViewControllerAndViewModelBinder<ViewController: UIViewController, ViewModel: AnyObject> {
	let viewController: ViewController
	let viewModel: ViewModel
	
	var subscriptions: Set<AnyCancellable> = []
	
	init(viewController: ViewController, viewModel: ViewModel) {
		self.viewController = viewController
		self.viewModel = viewModel
	}
	
	// Abstract
	func setupBindings() {
		
	}
	
	func removeBindings() {
		subscriptions.removeAll()
	}
	
}
