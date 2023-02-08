//
//  ProfileStackCoordination.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import Foundation

protocol ViewingAlbumDetails: AnyObject {
	func viewAlbumDetails(_ album: Album)
}

protocol ViewingPhoto: AnyObject {
	func viewPhoto(_ photo: Photo)
}