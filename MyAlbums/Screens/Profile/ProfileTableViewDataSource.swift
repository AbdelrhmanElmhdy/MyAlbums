//
//  ProfileTableViewDataSource.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import UIKit
import SkeletonView

class ProfileTableViewDataSource: NSObject, SkeletonTableViewDataSource {
	// MARK: Properties
	
	var albums: [Album] = []
		
	// MARK: DataSource
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return albums.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ProfileViewController.albumCellReuseIdentifier, for: indexPath) as! ProfileTableViewCell
		
		cell.label.text = albums[indexPath.row].title
		cell.accessoryType = .disclosureIndicator
		
		return cell
	}
	
	func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
		return ProfileViewController.albumCellReuseIdentifier
	}
	
}
