import Foundation
import Combine
@testable import MyAlbums

class NetworkManagerMock<ObjectType: Decodable>: NetworkManagerProtocol {

	//MARK: - executeRequest<T: Decodable>

	var executeRequestCallsCount = 0
	var executeRequestCalled: Bool {
		return executeRequestCallsCount > 0
	}
	var executeRequestReceivedTarget: API?
	var executeRequestReceivedInvocations: [API] = []
	var executeRequestReturnedPublisher = PassthroughSubject<ObjectType, NetworkRequestError>()

	func executeRequest<T: Decodable>(_ target: API) -> AnyPublisher<T, NetworkRequestError> {
		executeRequestCallsCount += 1
		executeRequestReceivedTarget = target
		executeRequestReceivedInvocations.append(target)
		let publisher = executeRequestReturnedPublisher.eraseToAnyPublisher() as! AnyPublisher<T, NetworkRequestError>
		return publisher
	}

}
