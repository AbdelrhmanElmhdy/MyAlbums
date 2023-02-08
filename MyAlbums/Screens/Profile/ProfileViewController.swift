//
//  ProfileViewController.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

class ProfileViewController: UITableViewController, PresentsToast {
	// MARK: Properties
	
	static let headerReuseIdentifier = "headerReuseIdentifier"
	static let albumCellReuseIdentifier = "albumCellReuseIdentifier"
	
	private unowned let coordinator: ViewingAlbumDetails
	private let viewModel: ProfileViewModel
	
	let dataSource = ProfileTableViewDataSource()
	
	private lazy var dataBinder = ProfileViewControllerAndViewModelBinder(viewController: self, viewModel: viewModel)
	
	var toastView: ToastView = ToastView()
	let header = ProfileHeader(frame: CGRect(x: 0, y: 0, width: 0, height: 125))
	
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
		setupViewController()
		setupRefreshControl()
		setupTableView()
		setupHeader()
		dataBinder.setupBindings()
		startRefreshing()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .always
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		viewModel.isPresentingToast = false
	}

		
	// MARK: Setups
	
	func setupViewController() {
		title = .ui.profile
		view.backgroundColor = .systemBackground
	}
	
	func setupRefreshControl() {
		refreshControl = UIRefreshControl()
		refreshControl?.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
	}
	
	func setupTableView() {
		tableView.dataSource = dataSource
		tableView.register(ProfileTableViewSectionHeader.self, forHeaderFooterViewReuseIdentifier: Self.headerReuseIdentifier)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.albumCellReuseIdentifier)
	}
	
	func setupHeader() {		
		header.contentView.backgroundColor = .systemGray6
		header.contentView.layer.cornerRadius = 10
		
		tableView.tableHeaderView = header
	}
	
	// MARK: Actions
	
	@objc func didRefresh() {
		viewModel.refreshData()
	}
	
	// MARK: Connivence
	
	func startRefreshing() {
		DispatchQueue.main.async() {
			self.didRefresh()
		}
	}
	
	// MARK: UITableViewDelegate
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(
			withIdentifier: Self.headerReuseIdentifier
		) as! ProfileTableViewSectionHeader
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
				AppDelegate.shared.viewControllersFactory.makeProfileViewController(for: ProfileStackCoordinatorMock())
			}.previewDevice(PreviewDevice(rawValue: deviceName))
				.previewDisplayName(deviceName)
		}
	}
}
#endif
