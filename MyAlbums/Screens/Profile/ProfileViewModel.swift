//
//  ProfileViewModel.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import Foundation
import Combine

class ProfileViewModel {
	private let userService: UserServiceProtocol
	private let albumService: AlbumServiceProtocol
	
	var dataRefreshSubscription: AnyCancellable?
	
	enum LoadingState {
		case loading, noConnection, loaded
	}
	
	// MARK: State
	
	@Published var loadingState = LoadingState.loaded
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
		loadingState = .loading
		
		let currentUserId = Int.random(in: 1...10)
		
		let userDataSubscription = userService.fetchUser(ofId: currentUserId)
		let userAlbumsSubscription = albumService.fetchAlbums(forUserId: currentUserId)
		
		dataRefreshSubscription = Publishers.CombineLatest(userDataSubscription, userAlbumsSubscription)
			.delay(for: 0.1, scheduler: RunLoop.main) // To show to the user that a refresh has occurred.
			.sink(receiveCompletion: didReceiveDataRefreshCompletion) { [weak self] user, albums in
				self?.userName = user.name
				self?.userAddress = String(describing: user.address)
				self?.albums = albums
				self?.loadingState = .loaded
			}
	}
	
	private func didReceiveDataRefreshCompletion(completion: Subscribers.Completion<NetworkRequestError>) {
		loadingState = .loaded
		
		switch completion {
		case .failure(let error): handleDataRefreshError(error)
		default: return
		}
	}
	
	private func handleDataRefreshError(_ error: NetworkRequestError) {
		switch error {
		case .failedToConnectToInternet, .requestTimedOut: loadingState = .noConnection
		default: loadingState = .loaded
		}
		
		toastTitle = error.userFriendlyDescription
		toastDetailsDescription = error.userFriendlyAdvice
		isPresentingToast = true
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
			if self?.isToastExpanded == false { self?.isPresentingToast = false }
		}
		
		if error.isFatal { ErrorManager.reportError(error) }
	}
	
}
