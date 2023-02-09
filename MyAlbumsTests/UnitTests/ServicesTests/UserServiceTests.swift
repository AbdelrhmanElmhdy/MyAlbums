//
//  UserServiceTests.swift
//  MyAlbumsTests
//
//  Created by Abdelrhman Elmahdy on 09/02/2023.
//

import XCTest
import Combine
@testable import MyAlbums

final class UserServiceTests: XCTestCase {
	
	func testUserFetch() {
		// Given
		let networkManagerMock = NetworkManagerMock<User>()
		let sut = UserService(networkManager: networkManagerMock)
		let expectedResponse = JSONFileLoader.loadJson(as: User.self, fromFile: .files.sampleUserResponse)!
		let didFetchUser = XCTestExpectation(description: #function)
		
		// When
		let cancellable = sut.fetchUser(ofId: 1)
			.sink { completion in
				switch completion {
				case .failure:
					didFetchUser.isInverted = true
					didFetchUser.fulfill()
				default: break
				}
			} receiveValue: { user in
				didFetchUser.isInverted = expectedResponse != user
				didFetchUser.fulfill()
			}
		
		networkManagerMock.executeRequestReturnedPublisher.send(expectedResponse)
		
		// Then
		wait(for: [didFetchUser], timeout: 0.1)
		XCTAssertNotNil(cancellable)
	}
	
}
