//
//  AlbumDetailsViewModelTests.swift
//  MyAlbumsTests
//
//  Created by Abdelrhman Elmahdy on 09/02/2023.
//

import XCTest
import Combine
@testable import MyAlbums

final class AlbumDetailsViewModelTests: XCTestCase {
	
	func testPhotosFetch() {
		// Given
		let photoServiceMock = PhotoServiceMock()
		let expectedPhotos = JSONFileLoader.loadJson(as: [Photo].self, fromFile: .files.sampleAlbumPhotosResponse)!
		let sut = AlbumDetailsViewModel(album: .init(id: 0, title: ""), photoService: photoServiceMock)
		
		// When
		sut.fetchPhotos()
		
		XCTAssertEqual(sut.isLoading, true)
		
		photoServiceMock.fetchPhotosForAlbumIdReturnValue.send(expectedPhotos)
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			XCTAssertEqual(sut.isLoading, false)
			XCTAssertEqual(sut.photos, expectedPhotos)
		}
	}
	
}

