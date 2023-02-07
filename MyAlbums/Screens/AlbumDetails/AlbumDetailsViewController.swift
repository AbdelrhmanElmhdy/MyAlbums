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
	
	private unowned let coordinator: ViewingPhoto
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
	
	init(coordinator: ViewingPhoto, viewModel: AlbumDetailsViewModel) {
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
		let photo = dataSource.isFiltering ? dataSource.filteredPhotos[indexPath.row] : dataSource.photos[indexPath.row]
		coordinator.viewPhoto(photo)
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
