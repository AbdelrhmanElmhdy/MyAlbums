//
//  ProfileStackCoordination.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

protocol ViewingAlbumDetails: AnyObject {
	func viewAlbumDetails(_ album: Album)
}

protocol ViewingPhoto: AnyObject {
	func viewPhoto(_ photo: Photo, thumbnailImage: UIImage?)
}
