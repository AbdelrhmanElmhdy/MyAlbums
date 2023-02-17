//
//  Cashable.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 11/02/2023.
//

import Foundation

protocol Cacheable {
	var cachePolicy: URLRequest.CachePolicy { get }
}
