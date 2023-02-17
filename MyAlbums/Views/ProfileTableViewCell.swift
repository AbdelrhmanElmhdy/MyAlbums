//
//  ProfileTableViewCell.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 13/02/2023.
//

import UIKit
import SkeletonView

class ProfileTableViewCell: UITableViewCell {
	
	let label = UILabel()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		accessoryType = .disclosureIndicator
		
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setup() {
		clipsToBounds = true
		isSkeletonable = true
		contentView.addSubview(label)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.isSkeletonable = true
		label.skeletonTextNumberOfLines = 1
		label.numberOfLines = 0
		label.linesCornerRadius = 3
		
		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
			label.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
			label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
			label.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
		])
	}
	
}
