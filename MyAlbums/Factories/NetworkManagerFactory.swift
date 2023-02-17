//
//  NetworkManagerFactory.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 09/02/2023.
//

import Foundation
import Moya

class NetworkManagerFactory {
	
	static func make(context: ENV.Context? = nil) -> NetworkManagerProtocol {
		let context = context ?? ENV.context
		let apiProvider = context == .test
			? MoyaProvider<API>(stubClosure: MoyaProvider.immediatelyStub)
			: MoyaProvider<API>(plugins: [CachePolicyPlugin()])
		
		return NetworkManager(apiProvider: apiProvider)
	}
	
}
