//
//  UserPreferencesServiceTests.swift
//  MyAlbumsTests
//
//  Created by Abdelrhman Elmahdy on 09/02/2023.
//

import XCTest
import Combine
@testable import MyAlbums

final class UserPreferencesServiceTests: XCTestCase {
	
	func testUpdatingUserInterfaceStyle() {
		// Given
		let userDefaultsManager = UserDefaultsManagerFactory.make(context: .test)
		let sut = UserPreferencesService(userDefaultsManager: userDefaultsManager)
		
		// When
		sut.updateUserInterfaceStyle(with: .dark)
		
		// Then
		XCTAssertEqual(userDefaultsManager.userPreferences.userInterfaceStyle, .dark)
	}
	
}
