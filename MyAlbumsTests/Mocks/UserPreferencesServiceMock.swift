// Generated using Sourcery 1.9.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
import Combine
import UIKit
@testable import MyAlbums

class UserPreferencesServiceMock: UserPreferencesServiceProtocol {
	
	//MARK: - updateUserInterfaceStyle
	
	var updateUserInterfaceStyleWithCallsCount = 0
	var updateUserInterfaceStyleWithCalled: Bool {
		return updateUserInterfaceStyleWithCallsCount > 0
	}
	var updateUserInterfaceStyleWithReceivedState: UIUserInterfaceStyle?
	var updateUserInterfaceStyleWithReceivedInvocations: [UIUserInterfaceStyle] = []
	var updateUserInterfaceStyleWithClosure: ((UIUserInterfaceStyle) -> Void)?
	
	func updateUserInterfaceStyle(with state: UIUserInterfaceStyle) {
		updateUserInterfaceStyleWithCallsCount += 1
		updateUserInterfaceStyleWithReceivedState = state
		updateUserInterfaceStyleWithReceivedInvocations.append(state)
		updateUserInterfaceStyleWithClosure?(state)
	}
	
	//MARK: - saveChanges
	
	var saveChangesCallsCount = 0
	var saveChangesCalled: Bool {
		return saveChangesCallsCount > 0
	}
	var saveChangesClosure: (() -> Void)?
	
	func saveChanges() {
		saveChangesCallsCount += 1
		saveChangesClosure?()
	}
	
}
