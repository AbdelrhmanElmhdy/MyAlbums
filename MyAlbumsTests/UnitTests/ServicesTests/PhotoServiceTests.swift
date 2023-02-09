//
//  PhotoServiceTests.swift
//  MyAlbumsTests
//
//  Created by Abdelrhman Elmahdy on 09/02/2023.
//

import XCTest
import Combine
@testable import MyAlbums

final class PhotoServiceTests: XCTestCase {
	
	func testPhotoFetch() {
		// Given
		let networkManagerMock = NetworkManagerMock<[Photo]>()
		let sut = PhotoService(networkManager: networkManagerMock)
		let expectedResponse = JSONFileLoader.loadJson(as: [Photo].self, fromFile: .files.sampleAlbumPhotosResponse)!
		let didFetchPhoto = XCTestExpectation(description: #function)
		
		// When
		let cancellable = sut.fetchPhotos(forAlbumId: 1)
			.sink { completion in
				switch completion {
				case .failure:
					didFetchPhoto.isInverted = true
					didFetchPhoto.fulfill()
				default: break
				}
			} receiveValue: { photos in
				didFetchPhoto.isInverted = expectedResponse != photos
				didFetchPhoto.fulfill()
			}
		
		networkManagerMock.executeRequestReturnedPublisher.send(expectedResponse)
		
		// Then
		wait(for: [didFetchPhoto], timeout: 0.1)
		XCTAssertNotNil(cancellable)
	}
	
}
