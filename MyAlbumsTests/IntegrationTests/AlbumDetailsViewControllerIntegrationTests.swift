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
	
	var viewModel: AlbumDetailsViewModel!
	var sut: AlbumDetailsViewController!
	
	override func setUp() {
		let networkManager = NetworkManagerFactory.make(context: .test)
		let photoService = PhotoService(networkManager: networkManager)
		viewModel = AlbumDetailsViewModel(album: .init(id: 0, title: ""), photoService: photoService)
		sut = AlbumDetailsViewController(coordinator: ProfileStackCoordinatorMock(), viewModel: viewModel)
	}
	
	func testDataRefresh() {
		// Given
		let expectedPhotos = JSONFileLoader.loadJson(as: [Photo].self, fromFile: .files.sampleAlbumPhotosResponse)!
		
		// When
		sut.didRefresh()
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			XCTAssertEqual(self.sut.collectionView.refreshControl?.isRefreshing, false)
			XCTAssertEqual(self.sut.dataSource.photos, expectedPhotos)
		}
	}
	
	func testImageSearch() {
		// Given
		let searchText = "Gi"
		let expectedPhotos = JSONFileLoader.loadJson(as: [Photo].self, fromFile: .files.sampleAlbumPhotosResponse)!.filter {
			$0.title.lowercased().contains(searchText.lowercased())
		}
		
		// When
		sut.didRefresh()
		viewModel.searchText = searchText
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
			XCTAssertEqual(self.sut.dataSource.isFiltering, true)
			XCTAssertEqual(self.sut.dataSource.filteredPhotos, expectedPhotos)
			XCTAssertEqual(self.sut.collectionView.numberOfItems(inSection: 0), expectedPhotos.count)
		}
	}
	
}

