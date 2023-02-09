//
//  SettingsViewModelTests.swift
//  MyAlbumsTests
//
//  Created by Abdelrhman Elmahdy on 09/02/2023.
//

import XCTest
import Combine
@testable import MyAlbums

final class SettingsViewModelTests: XCTestCase {
	
	func testSelectingUserInterfaceStyle() {
		// Given
		let userPreferencesServiceMock = UserPreferencesServiceMock()
		let sut = SettingsViewModel(userPreferencesService: userPreferencesServiceMock)
		
		// When
		sut.selectUserInterfaceStyle(.dark)
		
		// Then
		XCTAssertEqual(userPreferencesServiceMock.updateUserInterfaceStyleWithCallsCount, 1)
		XCTAssertEqual(userPreferencesServiceMock.updateUserInterfaceStyleWithReceivedState, .dark)
	}
	
}

