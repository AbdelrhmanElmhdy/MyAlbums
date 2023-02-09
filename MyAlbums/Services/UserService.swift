//
//  UserService.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Combine

class UserService: UserServiceProtocol {
	private let networkManager: NetworkManagerProtocol
	
	init(networkManager: NetworkManagerProtocol) {
		self.networkManager = networkManager
	}
	
	func fetchUser(ofId id: Int) -> AnyPublisher<User, NetworkRequestError> {
		networkManager.executeRequest(.user(ofId: id))
	}
}
