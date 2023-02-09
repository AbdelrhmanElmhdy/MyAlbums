//
//  AlbumDetailsViewControllerIntegrationTests.swift
//  MyAlbumsTests
//
//  Created by Abdelrhman Elmahdy on 09/02/2023.
//

import XCTest
import Combine
@testable import MyAlbums

final class AlbumDetailsViewControllerIntegrationTests: XCTestCase {
	
	func testDataRefresh() {
		// Given
		let networkManager = NetworkManagerFactory.make(context: .test)
		let photoService = PhotoService(networkManager: networkManager)
		let expectedPhotos = JSONFileLoader.loadJson(as: [Photo].self, fromFile: .files.sampleAlbumPhotosResponse)!
		let viewModel = AlbumDetailsViewModel(album: .init(id: 0, title: ""), photoService: photoService)
		let sut = AlbumDetailsViewController(coordinator: ProfileStackCoordinatorMock(), viewModel: viewModel)
		
		// When
		sut.didRefresh()
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			XCTAssertEqual(sut.collectionView.refreshControl?.isRefreshing, false)
			XCTAssertEqual(sut.dataSource.photos, expectedPhotos)
		}
	}
	
}

