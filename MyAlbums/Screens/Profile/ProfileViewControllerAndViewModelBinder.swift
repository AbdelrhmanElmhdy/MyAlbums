//
//  ProfileViewControllerAndViewModelBinder.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import UIKit
import CombineCocoa
import SkeletonView

class ProfileViewControllerAndViewModelBinder: ViewControllerAndViewModelBinder<ProfileViewController, ProfileViewModel> {
		
	override func setupBindings() {
		// userName
		viewModel.$userName
			.receive(on: DispatchQueue.main)
			.map { $0 }
			.assign(to: \.userName, on: viewController.header)
			.store(in: &subscriptions)

		// userAddress
		viewModel.$userAddress
			.receive(on: DispatchQueue.main)
			.map { $0 }
			.assign(to: \.userAddress, on: viewController.header)
			.store(in: &subscriptions)
		
		// albums
		viewModel.$albums
			.receive(on: DispatchQueue.main)
			.sink (receiveValue: {
				self.viewController.dataSource.albums = $0
				self.viewController.tableView.reloadData()
			})
			.store(in: &subscriptions)
		
		// loadingState
		viewModel.$loadingState
			.receive(on: DispatchQueue.main)
			.removeDuplicates()
			.sink (receiveValue: { loadingState in
				if loadingState == .loading {
					self.resetTableView()
					self.showAnimatedSkeleton()
					self.beginRefreshingRefreshControl()
					return
				}
				
				self.hideAnimatedSkeleton()
				self.viewController.tableView.restore()
				self.stopRefreshingRefreshControl()
				
				if loadingState == .noConnection {
					self.viewController.tableView.setNoInternetConnectionMessage(
						tryAgainButtonTapHandler: #selector(ProfileViewController.didRefresh),
						tabHandlerTarget: self.viewController
					)
				}
			})
			.store(in: &subscriptions)
		
		viewController.tableView.refreshControl?.isRefreshingPublisher
			.receive(on: DispatchQueue.main)
			.removeDuplicates()
			.sink { refreshing in
				if refreshing {
					self.viewModel.loadingState = .loading
				}
			}
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
	
	private func resetTableView() {
		viewModel.albums = []
		viewModel.userName = ""
		viewModel.userAddress = ""
		viewController.tableView.restore()
	}
	
	private func showAnimatedSkeleton() {
		viewController.header.contentView.showAnimatedSkeleton(usingColor: .systemGray5)
		viewController.tableView.showAnimatedSkeleton(usingColor: .systemGray5)
	}
	
	private func hideAnimatedSkeleton() {
		viewController.header.contentView.stopSkeletonAnimation()
		viewController.header.contentView.hideSkeleton()
		
		viewController.tableView.stopSkeletonAnimation()
		viewController.tableView.hideSkeleton()
	}
	
	private func beginRefreshingRefreshControl() {
		guard viewController.tableView.refreshControl?.isRefreshing != true else { return }
		viewController.tableView.refreshControl?.beginRefreshing()
	}
	
	private func stopRefreshingRefreshControl() {
		viewController.tableView.refreshControl?.endRefreshing()
	}
	
}

