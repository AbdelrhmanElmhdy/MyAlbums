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
	
	var isFiltering = false
	
	var images: [UIImage] = []
	var filteredImages: [UIImage] = []
	
	// MARK: DataSource
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return isFiltering ? filteredImages.count : images.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumDetailsViewController.imageReuseIdentifier",
																									for: indexPath) as! AlbumCollectionViewCell
		
		cell.image = isFiltering ? filteredImages[indexPath.row] : images[indexPath.row]
		return cell
	}
	
}
