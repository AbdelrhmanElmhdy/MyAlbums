//
//  RemoteImageView.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import UIKit
import ShimmerSwift

let imageCache = NSCache<AnyObject, AnyObject>()


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
	
	init(source: URL? = nil) {
		self.source = source
		super.init(frame: .zero)
		
		addSubview(shimmeringView)
		shimmeringView.translatesAutoresizingMaskIntoConstraints = false
		shimmeringView.fillSuperview()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setImage(from source: URL) {
		
		if let imageFromCache = imageCache.object(forKey: source.absoluteURL as AnyObject) as? UIImage {
			self.image = imageFromCache
			return
		}
		
		let task = URLSession.shared.dataTask(with: source) { data, response, error in
			guard let data = data, error == nil else { return }
			
			DispatchQueue.main.async() {
				if let image = UIImage(data: data) {
					imageCache.setObject(image, forKey: source.absoluteURL as AnyObject)
					self.image = image
				}
			}
		}
		
		task.resume()
	}
	
}

