//
//  NetworkManagerTests.swift
//  MyAlbumsTests
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import XCTest
import Combine
@testable import MyAlbums

final class NetworkManagerTests: XCTestCase {
	
	func testRequest<T: Decodable & Equatable>(_ target: API, expectedResponse: T) {
		// Given
		let sut = NetworkManagerFactory.make(context: .test)
		let didFetchResponse = XCTestExpectation(description: #function)
		let publisher: AnyPublisher<T, NetworkRequestError> = sut.executeRequest(target)
		
		// When
		let cancellable = publisher.sink { completion in
			switch completion {
			case .failure(let error):
				print(error)
				didFetchResponse.isInverted = true
				didFetchResponse.fulfill()
			default: break
			}
		} receiveValue: { response in
			didFetchResponse.isInverted = expectedResponse != response
			didFetchResponse.fulfill()
		}
		
		// Then
		wait(for: [didFetchResponse], timeout: 0.1)
		XCTAssertNotNil(cancellable)
	}
	
	func testUserFetch() {
		let expectedResponse = JSONFileLoader.loadJson(as: User.self, fromFile: .files.sampleUserResponse)!
		testRequest(.user(ofId: 1), expectedResponse: expectedResponse)
	}
	
	func testUserAlbumsFetch() {
		let expectedResponse = JSONFileLoader.loadJson(as: [Album].self, fromFile: .files.sampleUserAlbumsResponse)!
		testRequest(.albums(forUserId: 1), expectedResponse: expectedResponse)
	}
	
	func testAlbumPhotosFetch() {
		let expectedResponse = JSONFileLoader.loadJson(as: [Photo].self, fromFile: .files.sampleAlbumPhotosResponse)!
		testRequest(.photos(forAlbumId: 1), expectedResponse: expectedResponse)
	}
	
}
