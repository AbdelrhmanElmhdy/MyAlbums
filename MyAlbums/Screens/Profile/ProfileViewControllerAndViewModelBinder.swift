//
//  ProfileViewControllerAndViewModelBinder.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import UIKit
import CombineCocoa

class ProfileViewControllerAndViewModelBinder: ViewControllerAndViewModelBinder<ProfileViewController, ProfileViewModel> {
	
	override func setupBindings() {
		// userName
		viewModel.$userName
			.receive(on: DispatchQueue.main)
			.map { $0 }
			.assign(to: \.text, on: viewController.header.nameLabel, animation: .fade(duration: 0.3))
			.store(in: &subscriptions)

		// userAddress
		viewModel.$userAddress
			.receive(on: DispatchQueue.main)
			.map { $0 }
			.assign(to: \.text, on: viewController.header.addressLabel, animation: .fade(duration: 0.3))
			.store(in: &subscriptions)
		
		// albums
		viewModel.$albums
			.receive(on: DispatchQueue.main)
			.sink (receiveValue: {
				self.viewController.dataSource.albums = $0
				self.viewController.tableView.reloadData()
			})
			.store(in: &subscriptions)
		
		// isLoading
		viewModel.$isLoading
			.receive(on: DispatchQueue.main)
			.removeDuplicates()
			.sink (receiveValue: {
				if $0 {
					guard self.viewController.refreshControl?.isRefreshing != true else { return }
					self.viewController.refreshControl?.beginRefreshing()
				} else {
					self.viewController.refreshControl?.endRefreshing()
				}
			})
			.store(in: &subscriptions)
		
		viewController.refreshControl?.isRefreshingPublisher
			.receive(on: DispatchQueue.main)
			.removeDuplicates()
			.assign(to: \.isLoading, on: viewModel)
			.store(in: &subscriptions)
		
		
	}
	
}

