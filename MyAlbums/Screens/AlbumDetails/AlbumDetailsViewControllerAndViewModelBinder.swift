//
//  AlbumDetailsViewControllerAndViewModelBinder.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Foundation
import Combine
import CombineCocoa

class AlbumDetailsViewControllerAndViewModelBinder: ViewControllerAndViewModelBinder<AlbumDetailsViewController, AlbumDetailsViewModel> {
	
	override func setupBindings() {
		// photos
		
		viewModel.$photos
			.receive(on: DispatchQueue.main)
			.sink {
				self.viewController.dataSource.photos = $0
				self.viewController.collectionView.reloadData()
			}
			.store(in: &subscriptions)
		
		// isLoading
		
		viewModel.$isLoading
			.receive(on: DispatchQueue.main)
			.removeDuplicates()
			.sink {
				let refreshControl = self.viewController.collectionView.refreshControl
				if $0 {
					guard refreshControl?.isRefreshing != true else { return }
					refreshControl?.beginRefreshing()
				} else {
					refreshControl?.endRefreshing()
				}
			}
			.store(in: &subscriptions)
		
		viewController.collectionView.refreshControl?.isRefreshingPublisher
			.receive(on: DispatchQueue.main)
			.removeDuplicates()
			.assign(to: \.isLoading, on: viewModel)
			.store(in: &subscriptions)
		
		// searchText
		
		viewController.navigationItem.searchController?.searchBar.textDidChangePublisher
			.debounce(for: 0.15, scheduler: RunLoop.main)
			.sink{ [weak self] searchText in
				self?.viewModel.searchText = searchText
				self?.viewController.dataSource.searchText = searchText
				self?.viewController.collectionView.reloadData()
			}
			.store(in: &subscriptions)
	}
	
}
