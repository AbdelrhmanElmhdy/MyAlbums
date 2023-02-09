// Generated using Sourcery 1.9.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
import Combine
@testable import MyAlbums

class UserServiceMock: UserServiceProtocol {	
	
	//MARK: - fetchUser
	
	var fetchUserOfIdCallsCount = 0
	var fetchUserOfIdCalled: Bool {
		return fetchUserOfIdCallsCount > 0
	}
	var fetchUserOfIdReceivedId: Int?
	var fetchUserOfIdReceivedInvocations: [Int] = []
	var fetchUserOfIdReturnValue = PassthroughSubject<User, NetworkRequestError>()
	
	func fetchUser(ofId id: Int) -> AnyPublisher<User, NetworkRequestError> {
		fetchUserOfIdCallsCount += 1
		fetchUserOfIdReceivedId = id
		fetchUserOfIdReceivedInvocations.append(id)
		return fetchUserOfIdReturnValue.eraseToAnyPublisher()
	}
	
}
