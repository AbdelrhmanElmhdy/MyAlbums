//
//  UserServiceProtocol.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Combine

/// Handles all services related to the `User` type
protocol UserServiceProtocol {
	func fetchUser(ofId id: Int) -> AnyPublisher<User, NetworkRequestError>
}
