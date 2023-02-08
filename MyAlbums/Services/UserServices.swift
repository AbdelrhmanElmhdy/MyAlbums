//
//  UserServices.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Combine

class UserServices: UserServicesProtocol {
	private let networkManager = NetworkManager()
	
	func fetchUser(ofId id: Int) -> AnyPublisher<User, NetworkRequestError> {
		networkManager.executeRequest(.users(id: id))
	}
}
