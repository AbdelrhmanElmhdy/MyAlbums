//
//  ProfileViewModel.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import Foundation
import Combine

class ProfileViewModel {
	let userServices = UserServices()
	let albumServices = AlbumServices()
	
	var dataRefreshSubscription: AnyCancellable?
	
	// MARK: State
	
	@Published var isLoading: Bool = false
	@Published var userName: String = ""
	@Published var userAddress: String = ""
	@Published var albums: [Album] = []
	
	// MARK: Logic
	
	func refreshData() {
		isLoading = true
		
		let currentUserId = Int.random(in: 1...10)
		
		let userDataSubscription = userServices.fetchUser(ofId: currentUserId)
		let userAlbumsSubscription = albumServices.fetchAlbums(forUserId: currentUserId)
		
		dataRefreshSubscription = Publishers.CombineLatest(userDataSubscription, userAlbumsSubscription)
			.sink(receiveCompletion: { _ in }) { [weak self] user, albums in
				self?.userName = user.name
				self?.userAddress = String(describing: user.address)
				self?.albums = albums
				self?.isLoading = false
			}
		
	}
}
