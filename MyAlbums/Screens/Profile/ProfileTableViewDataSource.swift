//
//  ProfileTableViewDataSource.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import UIKit

class ProfileTableViewDataSource: NSObject, UITableViewDataSource {
	// MARK: Properties
	
	var albums: [Album] = []
		
	// MARK: DataSource
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return albums.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let albumTitle = albums[indexPath.row].title
		let cell = tableView.dequeueReusableCell(withIdentifier: ProfileViewController.albumCellReuseIdentifier, for: indexPath)

		if #available(iOS 14.0, *) {
			var contentConfiguration = UIListContentConfiguration.cell()
			contentConfiguration.text = albumTitle
			cell.contentConfiguration = contentConfiguration
		} else {
			cell.textLabel?.text = albumTitle
		}

		cell.accessoryType = .disclosureIndicator

		return cell
	}
}
