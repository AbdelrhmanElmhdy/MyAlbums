//
//  AlbumDetailsCollectionViewDataSource.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import Foundation

import UIKit

class AlbumDetailsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
	// MARK: Properties
			
	let placeHolderPhotos = Array(repeating: Photo(id: 0, albumId: 0, title: "", thumbnailUrl: "", url: ""), count: 8)
	
	lazy var photos: [Photo] = placeHolderPhotos
	var filteredPhotos: [Photo] = []
	
	var searchText = "" {
		didSet {
			filteredPhotos = photos.filter({( photo: Photo) -> Bool in
				photo.title.lowercased().contains(searchText.lowercased())
			})
		}
	}
	
	var isFiltering: Bool { !searchText.isEmpty }
		
	// MARK: DataSource
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return isFiltering ? filteredPhotos.count : photos.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: AlbumDetailsViewController.cellReuseIdentifier,
			for: indexPath
		) as! AlbumCollectionViewCell
		
		cell.photo = isFiltering ? filteredPhotos[indexPath.row] : photos[indexPath.row]
		return cell
	}
	
}
