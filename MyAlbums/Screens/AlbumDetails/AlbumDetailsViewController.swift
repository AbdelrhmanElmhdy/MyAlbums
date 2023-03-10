//
//  AlbumDetailsViewController.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

class AlbumDetailsViewController: UICollectionViewController {
	// MARK: Properties
		
	static let cellReuseIdentifier = "ImageCell"
	
	private unowned let coordinator: ViewingPhoto & PoppingPreviewedPhoto
	private let viewModel: AlbumDetailsViewModel
	
	let dataSource = AlbumDetailsCollectionViewDataSource()
	private(set) lazy var dataBinder = AlbumDetailsViewControllerAndViewModelBinder(viewController: self,
																																									viewModel: viewModel)
	private let searchController = UISearchController(searchResultsController: nil)
	
	fileprivate let numberOfImagesPerRow: CGFloat = 3
	fileprivate let sectionInsets = UIEdgeInsets(top: 35.0, left: 0, bottom: 35.0, right: 0)
	
	private var isFiltering: Bool {
		return searchController.isActive && !searchBarIsEmpty
	}
	
	private var searchBarIsEmpty: Bool {
		return searchController.searchBar.text?.isEmpty ?? true
	}
	
	// MARK: Initialization
	
	init(coordinator: ViewingPhoto & PoppingPreviewedPhoto, viewModel: AlbumDetailsViewModel) {
		self.viewModel = viewModel
		self.coordinator = coordinator
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		
		super.init(collectionViewLayout: layout)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Life Cycle
		
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViewController()
		setupRefreshControl()
		setupCollectionView()
		setupSearchController()
		dataBinder.setupBindings()
		didRefresh()
	}
	
	// MARK: Setups
	
	private func setupViewController() {
		view.backgroundColor = .systemBackground
		definesPresentationContext = true
	}
	
	func setupRefreshControl() {
		collectionView.refreshControl = UIRefreshControl()
		collectionView.refreshControl?.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
	}
		
	private func setupCollectionView() {
		collectionView.dataSource = dataSource
		collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: Self.cellReuseIdentifier)
	}
	
	private func setupSearchController() {
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = .ui.imagesSearchBarPlaceholder
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
	}
	
	// MARK: Actions
	
	@objc func didRefresh() {
		viewModel.fetchPhotos()
	}
}

// MARK: UICollectionViewDelegate

extension AlbumDetailsViewController {
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath) as! AlbumCollectionViewCell
		let photo = dataSource.isFiltering ? dataSource.filteredPhotos[indexPath.row] : dataSource.photos[indexPath.row]
		coordinator.viewPhoto(photo, thumbnailImage: cell.image)
	}
		
}

// MARK: UICollectionViewDelegateFlowLayout

extension AlbumDetailsViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		let paddingSpace = sectionInsets.left + sectionInsets.right
		let availableWidth = collectionView.frame.width - paddingSpace
		let itemWidth = availableWidth / numberOfImagesPerRow
		
		return CGSize(width: itemWidth, height: itemWidth)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int
	) -> UIEdgeInsets {
		return sectionInsets
	}

}

// MARK:  Peek & Pop

extension AlbumDetailsViewController {
	
	private func makePreviewActionsMenu(for previewedPhotoDetailsVC: PhotoDetailsViewController) -> UIMenu {
		let shareAction = UIAction(title: .ui.share, image: .share, identifier: nil) { [weak self] _ in
			self?.didPressShare(previewedPhotoDetailsVC: previewedPhotoDetailsVC)
		}
		
		return UIMenu(title: "", children: [shareAction])
	}
	
	private func didPressShare(previewedPhotoDetailsVC: PhotoDetailsViewController) {
		guard let image = previewedPhotoDetailsVC.controlledView.imageView.image else { return }
		let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
		self.present(activityController, animated: true)
	}
	
	override func collectionView(_ collectionView: UICollectionView,
															 contextMenuConfigurationForItemAt indexPath: IndexPath,
															 point: CGPoint) -> UIContextMenuConfiguration? {
		let cell = collectionView.cellForItem(at: indexPath) as! AlbumCollectionViewCell
		guard let thumbnailImage = cell.image else { return nil }
		
		let photo = dataSource.isFiltering ? dataSource.filteredPhotos[indexPath.row] : dataSource.photos[indexPath.row]
		let photoDetailsVC = PhotoDetailsViewController(selectedPhoto: photo, thumbnailImage: thumbnailImage)
		
		let config = UIContextMenuConfiguration(identifier: indexPath as NSIndexPath,
																						previewProvider: { photoDetailsVC },
																						actionProvider: { [weak self] _ in self?.makePreviewActionsMenu(for: photoDetailsVC)})
																						
		return config
	}
	
	override func collectionView(_ collectionView: UICollectionView,
															 willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
															 animator: UIContextMenuInteractionCommitAnimating) {
		
		guard let previewViewController = animator.previewViewController else { return }
		
		animator.addCompletion {
			self.coordinator.popPhoto(inPreviewedViewController: previewViewController)
		}
	}
	
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct AlbumDetailsViewController_Preview: PreviewProvider {
	static var previews: some View {
		ForEach(DEVICE_NAMES, id: \.self) { deviceName in
			UIViewControllerPreview {
				AppDelegate.shared.viewControllersFactory.makeAlbumDetailsViewController(for: ProfileStackCoordinatorMock(),
																																								 album: Album(id: 0, title: ""))
			}.previewDevice(PreviewDevice(rawValue: deviceName))
				.previewDisplayName(deviceName)
		}
	}
}
#endif
