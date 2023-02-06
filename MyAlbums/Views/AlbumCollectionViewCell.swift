//
//  AlbumCollectionViewCell.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//


import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
	
	var image: UIImage? = nil {
		didSet {
			imageView.image = image
		}
	}
	
	private let imageView: UIImageView = {
		let imageView = UIImageView()
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
