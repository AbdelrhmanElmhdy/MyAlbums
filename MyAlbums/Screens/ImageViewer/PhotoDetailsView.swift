//
//  PhotoDetailsView.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import UIKit

class PhotoDetailsView: UIView {
	let scrollView = UIScrollView()
	let imageView = RemoteImageView()
	
	var didLoadImage = false {
		didSet {
			centerXConstraint.priority = didLoadImage ? .defaultLow : .defaultHigh
			centerYConstraint.priority = didLoadImage ? .defaultLow : .defaultHigh
		}
	}
	
	private var centerXConstraint: NSLayoutConstraint!
	private var centerYConstraint: NSLayoutConstraint!
	
	init() {
		super.init(frame: .zero)
		setupSubviews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupSubviews() {
		setupScrollView()
		setupImageView()
	}
	
	private func setupScrollView() {
		scrollView.minimumZoomScale = 1.0
		scrollView.maximumZoomScale = 3.0
		scrollView.showsVerticalScrollIndicator = false
		scrollView.showsHorizontalScrollIndicator = false
		
		addSubview(scrollView)
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
		])
	}
	
	private func setupImageView() {
		imageView.didLoad = {[weak self] in
			self?.didLoadImage = true
		}
		imageView.contentMode = .scaleAspectFit
		imageView.isUserInteractionEnabled = true
		
		scrollView.addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		centerXConstraint = imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
		centerYConstraint = imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
		centerXConstraint.priority = .defaultHigh
		centerYConstraint.priority = .defaultHigh
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			centerXConstraint,
			centerYConstraint,
		])
	}
}
