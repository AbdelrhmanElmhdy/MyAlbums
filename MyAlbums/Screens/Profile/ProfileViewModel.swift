//
//  ProfileViewModel.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import Foundation
import Combine

class ProfileViewModel {
	let userService: UserServiceProtocol
	let albumService: AlbumServiceProtocol
	
	var dataRefreshSubscription: AnyCancellable?
	
	// MARK: State
	
	@Published var isLoading: Bool = false
	@Published var userName: String = ""
	@Published var userAddress: String = ""
	@Published var albums: [Album] = []
	@Published var isPresentingToast = false
	@Published var isToastExpanded = false
	@Published var toastTitle = ""
	@Published var toastDetailsDescription = ""
	
	// MARK: Initialization
	
	init(userService: UserServiceProtocol, albumService: AlbumServiceProtocol) {
		self.userService = userService
		self.albumService = albumService
	}
	
	// MARK: Logic
	
	func refreshData() {
		isLoading = true
		
		let currentUserId = Int.random(in: 1...10)
		
		let userDataSubscription = userService.fetchUser(ofId: currentUserId)
		let userAlbumsSubscription = albumService.fetchAlbums(forUserId: currentUserId)
		
		dataRefreshSubscription = Publishers.CombineLatest(userDataSubscription, userAlbumsSubscription)
			.sink(receiveCompletion: didReceiveDataRefreshCompletion) { [weak self] user, albums in
				self?.userName = user.name
				self?.userAddress = String(describing: user.address)
				self?.albums = albums
				self?.isLoading = false
			}
	}
	
	private func didReceiveDataRefreshCompletion(completion: Subscribers.Completion<NetworkRequestError>) {
		isLoading = false
		
		switch completion {
		case .failure(let error): handleDataRefreshError(error)
		default: return
		}
	}
	
	func handleDataRefreshError(_ error: NetworkRequestError) {
		toastTitle = error.userFriendlyDescription
		toastDetailsDescription = error.userFriendlyAdvice
		isPresentingToast = true
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
			if !self.isToastExpanded { self.isPresentingToast = false }
		}
		
		if error.isFatal { ErrorManager.reportError(error) }
	}
	
}
