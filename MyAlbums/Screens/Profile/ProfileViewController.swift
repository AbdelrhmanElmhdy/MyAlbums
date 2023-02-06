//
//  ProfileViewController.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

class ProfileViewController: UITableViewController {
	// MARK: Properties
	
	static let headerReuseIdentifier = "headerReuseIdentifier"
	static let albumCellReuseIdentifier = "albumCellReuseIdentifier"
	
	private unowned let coordinator: ViewingAlbumDetails
	private let viewModel: ProfileViewModel
	
	private let dataSource = ProfileTableViewDataSource()
	
	// MARK: Initialization
	
	init(coordinator: ViewingAlbumDetails, viewModel: ProfileViewModel) {
		self.coordinator = coordinator
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = .ui.profile
		view.backgroundColor = .systemBackground
		
		tableView.dataSource = dataSource
		updateData()
		tableView.register(ProfileHeader.self, forHeaderFooterViewReuseIdentifier: Self.headerReuseIdentifier)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.albumCellReuseIdentifier)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .always
	}
	
	func updateData() {
		viewModel.fetchUserData()
		dataSource.albums = [
			Album(id: 1, title: "Test 1"),
			Album(id: 2, title: "Test 2"),
			Album(id: 3, title: "Test 3"),
			Album(id: 4, title: "Test 4"),
		]
		tableView.reloadData()
	}
	

	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.headerReuseIdentifier) as! ProfileHeader
		header.nameLabel.text = "Abdelrhman"
		header.addressLabel.text = "Egypt"
		header.sectionTitle.text = .ui.albumsTableViewTitle
		return header
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedAlbum = dataSource.albums[indexPath.row]
		coordinator.viewAlbumDetails(selectedAlbum)
	}
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ProfileViewController_Preview: PreviewProvider {
	static var previews: some View {
		ForEach(DEVICE_NAMES, id: \.self) { deviceName in
			UIViewControllerPreview {
				AppDelegate.shared.viewControllersFactory.makeProfileViewController(for: ProfileCoordinatorMock())
			}.previewDevice(PreviewDevice(rawValue: deviceName))
				.previewDisplayName(deviceName)
		}
	}
}
#endif
