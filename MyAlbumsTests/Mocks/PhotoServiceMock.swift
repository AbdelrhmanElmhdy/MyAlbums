// Generated using Sourcery 1.9.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
import Combine
@testable import MyAlbums

class PhotoServiceMock: PhotoServiceProtocol {
		
	//MARK: - fetchPhotos
	
	var fetchPhotosForAlbumIdCallsCount = 0
	var fetchPhotosForAlbumIdCalled: Bool {
		return fetchPhotosForAlbumIdCallsCount > 0
	}
	var fetchPhotosForAlbumIdReceivedForAlbumId: Int?
	var fetchPhotosForAlbumIdReceivedInvocations: [Int] = []
	var fetchPhotosForAlbumIdReturnValue = PassthroughSubject<[Photo], NetworkRequestError>()
	
	func fetchPhotos(forAlbumId: Int) -> AnyPublisher<[Photo], NetworkRequestError> {
		fetchPhotosForAlbumIdCallsCount += 1
		fetchPhotosForAlbumIdReceivedForAlbumId = forAlbumId
		fetchPhotosForAlbumIdReceivedInvocations.append(forAlbumId)
		return fetchPhotosForAlbumIdReturnValue.eraseToAnyPublisher()
	}
	
}
