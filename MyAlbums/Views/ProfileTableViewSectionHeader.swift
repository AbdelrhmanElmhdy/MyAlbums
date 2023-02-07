//
//  ProfileTableViewSectionHeader.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import UIKit

class ProfileTableViewSectionHeader: UITableViewHeaderFooterView {
	// MARK: Properties
	
	let sectionTitle: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 18, weight: .semibold)
		return label
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
		contentView.addSubview(sectionTitle)
		sectionTitle.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			sectionTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			sectionTitle.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
			sectionTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			sectionTitle.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
		])
	}
}
