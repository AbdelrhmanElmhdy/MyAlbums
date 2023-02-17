//
//  CachePolicyPlugin.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 11/02/2023.
//

import Foundation
import Moya
import Network


final class CachePolicyPlugin: PluginType {
	let monitor = NWPathMonitor()
	
	var isConnected = false
	
	init() {
		monitor.pathUpdateHandler = { [weak self] path in
			self?.isConnected = path.status == .satisfied
		}
		
		let queue = DispatchQueue(label: "Monitor")
		monitor.start(queue: queue)
	}

	
	public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
		if let target = target as? Cacheable {
			var mutableRequest = request
			
			// In the case of no network connection the request should attempt to return the cached response.
			mutableRequest.cachePolicy = isConnected ? target.cachePolicy : .returnCacheDataElseLoad
			return mutableRequest
		}
		
		return request
	}
	
	
}
