//
//  URLCache+Ext.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 12/02/2023.
//

import Foundation

extension URLCache {
	
	static func configureSharedCache(memoryCapacity: Int = 0, diskCapacity: Int = 0, diskPath: String? = Bundle.main.bundleIdentifier) {
		shared = {
			let cacheDirectory = (NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as String).appendingFormat("/\(diskPath ?? "cache")/" )
			return URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: cacheDirectory)
		}()
	}
	
}
