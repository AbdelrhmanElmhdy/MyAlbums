//
//  RemoteImageView.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import UIKit
import ShimmerSwift

/// An Image view that fetches its image from the url assigned to its `source` property, and displays a shimmering redacted animation
/// until the remote image is fetched.
class RemoteImageView: UIImageView {
	
	let shimmeringView: ShimmeringView = {
		let view = ShimmeringView()
		view.layer.cornerRadius = 8
		view.shimmerSpeed = 0.1
		view.shimmerPauseDuration = 0.8
		view.isShimmering = true
		let contentView = UIView()
		contentView.backgroundColor = .systemGray4
		view.contentView = contentView

		return view
	}()
	
	/// The URL of the remote image.
	var source: URL? {
		didSet {
			if let source = source {
				shimmeringView.isShimmering = true
				shimmeringView.isHidden = false
				
				setImage(from: source)
			} else {
				backgroundColor = .systemGray5
			}
		}
	}
	
	override var image: UIImage? {
		didSet {
			if image != nil {
				shimmeringView.isShimmering = false
				shimmeringView.isHidden = true
			}
		}
	}
	
	let progressView = UIProgressView()
	
	private var observation: NSKeyValueObservation?
	
	var didLoad: (() -> Void)?
	
	init(source: URL? = nil, showProgressView: Bool = false, didLoad: (() -> Void)? = nil) {
		self.source = source
		self.didLoad = didLoad
		super.init(frame: .zero)
		
		addSubview(shimmeringView)
		shimmeringView.translatesAutoresizingMaskIntoConstraints = false
		shimmeringView.fillSuperview()
		setupProgressView(showProgressView: showProgressView)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupProgressView(showProgressView: Bool) {
		addSubview(progressView)
		progressView.translatesAutoresizingMaskIntoConstraints = false
		progressView.isHidden = showProgressView ? false : true
		progressView.progressTintColor = .systemBlue
		
		NSLayoutConstraint.activate([
			progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
			progressView.bottomAnchor.constraint(equalTo: bottomAnchor),
			progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
			progressView.heightAnchor.constraint(equalToConstant: 4),
		])
	}
	
	func setImage(from source: URL) {
		
		let request = URLRequest(url: source, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15)
		
		let task = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
			DispatchQueue.main.async() {
				guard let data = data, error == nil else { return }
				
				if let image = UIImage(data: data) {
					self?.didLoad?()
					self?.image = image
				}
			}
		}
		
		observation = task.progress.observe(\.fractionCompleted) { [weak self] progress, _ in
			DispatchQueue.main.async {
				let fractionCompleted = max(0.1, Float(progress.fractionCompleted))
				self?.progressView.progress = fractionCompleted
				
				if fractionCompleted == 1 {
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { self?.progressView.isHidden = true }
				}
			}
		}
		
		task.resume()
	}
	
}

