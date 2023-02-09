//
//  ProfileViewModelTests.swift
//  MyAlbumsTests
//
//  Created by Abdelrhman Elmahdy on 09/02/2023.
//

import XCTest
import Combine
@testable import MyAlbums

final class ProfileViewModelTests: XCTestCase {
	
	func testDataRefresh() {
		// Given
		let userServiceMock = UserServiceMock()
		let albumServiceMock = AlbumServiceMock()
		let expectedUser = JSONFileLoader.loadJson(as: User.self, fromFile: .files.sampleUserResponse)!
		let expectedAlbums = JSONFileLoader.loadJson(as: [Album].self, fromFile: .files.sampleUserAlbumsResponse)!
		let sut = ProfileViewModel(userService: userServiceMock, albumService: albumServiceMock)
		
		// When
		sut.refreshData()
		
		XCTAssertEqual(sut.isLoading, true)
		
		userServiceMock.fetchUserOfIdReturnValue.send(expectedUser)
		albumServiceMock.fetchAlbumsForUserIdReturnValue.send(expectedAlbums)
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			XCTAssertEqual(sut.isLoading, false)
			XCTAssertEqual(sut.userName, expectedUser.name)
			XCTAssertEqual(sut.userAddress, String(describing: expectedUser.address))
			XCTAssertEqual(sut.albums, expectedAlbums)
		}
	}
	
}

