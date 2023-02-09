// Generated using Sourcery 1.9.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
import Combine
@testable import MyAlbums

class AlbumServiceMock: AlbumServiceProtocol {
		
	//MARK: - fetchAlbums
	
	var fetchAlbumsForUserIdCallsCount = 0
	var fetchAlbumsForUserIdCalled: Bool {
		return fetchAlbumsForUserIdCallsCount > 0
	}
	var fetchAlbumsForUserIdReceivedUserId: Int?
	var fetchAlbumsForUserIdReceivedInvocations: [Int] = []
	var fetchAlbumsForUserIdReturnValue = PassthroughSubject<[Album], NetworkRequestError>()
	
	func fetchAlbums(forUserId userId: Int) -> AnyPublisher<[Album], NetworkRequestError> {
		fetchAlbumsForUserIdCallsCount += 1
		fetchAlbumsForUserIdReceivedUserId = userId
		fetchAlbumsForUserIdReceivedInvocations.append(userId)
		return fetchAlbumsForUserIdReturnValue.eraseToAnyPublisher()
	}
	
}
