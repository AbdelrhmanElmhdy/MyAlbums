//
//  AlbumServiceTests.swift
//  MyAlbumsTests
//
//  Created by Abdelrhman Elmahdy on 09/02/2023.
//

import XCTest
import Combine
@testable import MyAlbums

final class AlbumServiceTests: XCTestCase {
	
	func testUserAlbumsFetch() {
		// Given
		let networkManagerMock = NetworkManagerMock<[Album]>()
		let sut = AlbumService(networkManager: networkManagerMock)
		let expectedResponse = JSONFileLoader.loadJson(as: [Album].self, fromFile: .files.sampleUserAlbumsResponse)!
		let didFetchAlbum = XCTestExpectation(description: #function)
		
		// When
		let cancellable = sut.fetchAlbums(forUserId: 1)
			.sink { completion in
				switch completion {
				case .failure:
					didFetchAlbum.isInverted = true
					didFetchAlbum.fulfill()
				default: break
				}
			} receiveValue: { albums in
				didFetchAlbum.isInverted = expectedResponse != albums
				didFetchAlbum.fulfill()
			}
		
		networkManagerMock.executeRequestReturnedPublisher.send(expectedResponse)
		
		// Then
		wait(for: [didFetchAlbum], timeout: 0.1)
		XCTAssertNotNil(cancellable)
	}
	
}
