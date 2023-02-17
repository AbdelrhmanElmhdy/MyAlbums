//
//  MyAlbumsUITests.swift
//  MyAlbumsUITests
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import XCTest

final class MyAlbumsUITests: XCTestCase {
	
	func testCoreFlow() {
		let app = XCUIApplication()
		app.launchEnvironment = [.env.context: ENV.Context.test.rawValue]
		app.launch()
		
		let userName = "Leanne Graham"
		let userAddress = "Kulas Light, Apt. 556, Gwenborough, 92998-3874"
		let albumTitle = "et rem non provident vel ut"
		
		let userNameLabel = app.staticTexts[userName]
		let userNameLabelExists = userNameLabel.waitForExistence(timeout: 5)
		
		let userAddressLabel = app.staticTexts[userAddress]
		let userAddressLabelExists = userAddressLabel.waitForExistence(timeout: 5)
		
		let albumCell = app.tables.cells.staticTexts[albumTitle]
		let albumCellExists = albumCell.waitForExistence(timeout: 5)
		
		XCTAssertTrue(userNameLabelExists)
		XCTAssertTrue(userAddressLabelExists)
		XCTAssertTrue(albumCellExists)
		
		albumCell.tap()
		
		let navigationBar = app.navigationBars[albumTitle]
		let searchBar = navigationBar.searchFields[.ui.imagesSearchBarPlaceholder]
		searchBar.tap()
		
		searchBar.typeText("Gi")
		XCTAssertEqual(app.collectionViews.cells.count, 3)
		app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
		
		let image = app.scrollViews.children(matching: .image).element
		image.doubleTap()
		image.doubleTap()
		
		app.navigationBars[.ui.profile].buttons[albumTitle].tap()
		navigationBar.buttons[.ui.cancel].tap()
		navigationBar.buttons[.ui.profile].tap()
	}
	       
}
