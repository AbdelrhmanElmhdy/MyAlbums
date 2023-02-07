//
//  ProfileHeader.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import UIKit

class ProfileHeader: UIView {
	// MARK: Properties
	
	let contentView = UIView()
	
	let nameLabel: UILabel = {
		let label = UILabel()
		
		label.numberOfLines = 2
		label.minimumScaleFactor = 0.7
		label.adjustsFontSizeToFitWidth = true
		label.font = .systemFont(ofSize: 18, weight: .bold)
		label.textColor = .label
		
		return label
	}()
	
	let addressLabel: UILabel = {
		let label = UILabel()
		
		label.numberOfLines = 3
		label.minimumScaleFactor = 0.7
		label.adjustsFontSizeToFitWidth = true
		label.font = .systemFont(ofSize: 18)
		label.textColor = .secondaryLabel
		
		return label
	}()
		
	private lazy var rootStackView = {
		let stackView = UIStackView(arrangedSubviews: [nameLabel, addressLabel])
		
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.alignment = .fill
		stackView.spacing = 6
		
		return stackView
	}()
	
	// MARK: Initialization
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubviews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: View Setup
	
	func setupSubviews() {
		setupContentView()
		setupRootStackView()
	}
	
	func setupContentView() {
		addSubview(contentView)
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
			contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
			contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
			contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
		])
	}
	
	func setupRootStackView() {
		contentView.addSubview(rootStackView)
		rootStackView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			rootStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			rootStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
			rootStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
			rootStackView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.95)
		])
	}
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ProfileHeader_Preview: PreviewProvider {
	static var previews: some View {
		UIViewPreview {
			let header = ProfileHeader()
			header.nameLabel.text = "Abdelrhman Elmahdy"
			header.addressLabel.text = "Cairo, Egypt"

			return header
		}.previewLayout(.sizeThatFits)
			.padding(10)
	}
}
#endif
