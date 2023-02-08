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
			.assign(to: \.userName, on: viewController.header, animation: .fade(duration: 0.3))
			.store(in: &subscriptions)

		// userAddress
		viewModel.$userAddress
			.receive(on: DispatchQueue.main)
			.map { $0 }
			.assign(to: \.userAddress, on: viewController.header, animation: .fade(duration: 0.3))
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
		
		// isPresentingToast
		viewModel.$isPresentingToast
			.receive(on: DispatchQueue.main)
			.sink (receiveValue: { isPresentingToast in
				if isPresentingToast {
					// don't try to present it if it's already presented
					guard self.viewController.toastView.isPresented != true else {
						self.viewController.toastView.collapse()
						return
					}
					
					self.viewController.presentToast(withTitle: self.viewModel.toastTitle,
																					 andDescription: self.viewModel.toastDetailsDescription,
																					 animated: true)
					return
				}
				
				// don't try to dismissed it if it's not presented
				guard self.viewController.toastView.isPresented == true else { return }
				self.viewController.dismissToast(animated: true)
			})
			.store(in: &subscriptions)
		
		// isToastExpanded
		viewController.toastView.$isExpanded.assign(to: \.isToastExpanded, on: viewModel).store(in: &subscriptions)
		
		// toastTitle
		viewModel.$toastTitle.assign(to: \.title, on: viewController.toastView).store(in: &subscriptions)
		
		// toastDetailsDescription
		viewModel.$toastDetailsDescription.assign(to: \.detailsDescription, on: viewController.toastView).store(in: &subscriptions)
		
	}
	
}

