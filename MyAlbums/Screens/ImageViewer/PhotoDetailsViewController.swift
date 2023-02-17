//
//  PhotoViewerViewController.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit
import Combine
import CombineCocoa

class PhotoDetailsViewController: UIViewController {
	// MARK: Properties
	
	private let controlledView = PhotoDetailsView()
	
	private let selectedPhoto: Photo
	private let thumbnailImage: UIImage?
	private let doubleTap =  UITapGestureRecognizer()
	private var subscriptions = Set<AnyCancellable>()
	
	// MARK: Initialization
	
	init(selectedPhoto: Photo, thumbnailImage: UIImage?) {
		self.selectedPhoto = selectedPhoto
		self.thumbnailImage = thumbnailImage
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Life Cycle
	
	override func loadView() {
		view = controlledView
	}
		
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		controlledView.scrollView.delegate = self
		controlledView.imageView.source = URL(string: selectedPhoto.url)
		controlledView.imageView.image = thumbnailImage
		
		setupShareButton()
		setupDoubleTapGestureRecognizer()
	}
	
	// MARK: Setups
	
	private func setupShareButton() {
		let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
		navigationItem.rightBarButtonItem = shareButton
		shareButton.tapPublisher.sink { self.didPressShare() }.store(in: &subscriptions)
	}
	
	private func setupDoubleTapGestureRecognizer() {
		doubleTap.numberOfTapsRequired = 2
		controlledView.imageView.addGestureRecognizer(doubleTap)
		doubleTap.tapPublisher.sink { _ in self.didDoubleTap() }.store(in: &subscriptions)
	}
	
	// MARK: Actions
	
	private func didPressShare() {
		guard let image = controlledView.imageView.image else { return }
		let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
		present(activityController, animated: true)
	}
	
	private func didDoubleTap() {
		let targetZoomScale = controlledView.scrollView.zoomScale == 1 ? 2.0 : 1.0
		controlledView.scrollView.setZoomScale(targetZoomScale, animated: true)
	}
	
}

// MARK: UIScrollViewDelegate

extension PhotoDetailsViewController: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		// Only enable zooming when the image view has finished loading the image
		// because supporting zooming on the thumbnail image introduces unnecessary complications
		// regarding the image view's constraints.
		
		return controlledView.didLoadImage ? controlledView.imageView : nil
	}
}
