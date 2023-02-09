//
//  ProfileViewControllerIntegrationTests.swift
//  MyAlbumsTests
//
//  Created by Abdelrhman Elmahdy on 09/02/2023.
//

import XCTest
import Combine
@testable import MyAlbums

final class ProfileViewControllerIntegrationTests: XCTestCase {
	
	func testDataRefresh() {
		// Given
		let networkManager = NetworkManagerFactory.make(context: .test)
		let userService = UserService(networkManager: networkManager)
		let albumService = AlbumService(networkManager: networkManager)
		
		let expectedUser = JSONFileLoader.loadJson(as: User.self, fromFile: .files.sampleUserResponse)!
		let expectedAlbums = JSONFileLoader.loadJson(as: [Album].self, fromFile: .files.sampleUserAlbumsResponse)!
		
		let viewModel = ProfileViewModel(userService: userService, albumService: albumService)
		let sut = ProfileViewController(coordinator: ProfileStackCoordinatorMock(), viewModel: viewModel)
		
		// When
		sut.didRefresh()
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			XCTAssertEqual(sut.refreshControl?.isRefreshing, false)
			XCTAssertEqual(sut.dataSource.albums, expectedAlbums)
			XCTAssertEqual(sut.header.userName, expectedUser.name)
			XCTAssertEqual(sut.header.userAddress, String(describing: expectedUser.address))
		}
	}
	
}

