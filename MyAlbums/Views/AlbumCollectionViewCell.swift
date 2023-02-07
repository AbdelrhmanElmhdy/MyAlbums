//
//  AlbumCollectionViewCell.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//


import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
	
	var photo: Photo? {
		didSet {
			guard let photo = photo else { return }
			imageView.source = URL(string: photo.thumbnailUrl)
		}
	}
	
	private let imageView: RemoteImageView = {
		let imageView = RemoteImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setup() {
		clipsToBounds = true
		contentView.addSubview(imageView)
		imageView.fillSuperview()
	}
	
}
