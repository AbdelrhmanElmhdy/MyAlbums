//
//  ProfileHeader.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import UIKit

class ProfileHeader: UITableViewHeaderFooterView {
	// MARK: Properties
	
	let nameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 18, weight: .bold)
		return label
	}()
	
	let addressLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 18)
		return label
	}()
	
	let sectionTitle: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 18, weight: .semibold)
		return label
	}()
	
	private lazy var rootStackView = {
		let stackView = UIStackView(arrangedSubviews: [nameLabel, addressLabel, sectionTitle])

		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.alignment = .fill
		stackView.spacing = 6
		stackView.setCustomSpacing(16, after: addressLabel)

		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	// MARK: Initialization
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: View Setup
	
	func setup() {
		contentView.addSubview(rootStackView)
		
		NSLayoutConstraint.activate([
			rootStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			rootStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
			rootStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			rootStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -25),
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
			let header = ProfileHeader(reuseIdentifier: "")
			header.nameLabel.text = "Abdelrhman Elmahdy"
			header.addressLabel.text = "Cairo, Egypt"

			return header
		}.previewLayout(.sizeThatFits)
			.padding(10)
	}
}
#endif
