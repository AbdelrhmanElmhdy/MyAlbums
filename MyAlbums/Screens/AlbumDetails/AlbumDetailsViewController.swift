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
	
	private unowned let coordinator: ViewingImage
	private let viewModel: AlbumDetailsViewModel
	
	private let dataSource = AlbumDetailsCollectionViewDataSource()
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
	
	init(coordinator: ViewingImage, viewModel: AlbumDetailsViewModel) {
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
		setupCollectionView()
		setupSearchController()
		didRefresh()
	}
	
	private func setupViewController() {
		view.backgroundColor = .systemBackground
		definesPresentationContext = true
	}
		
	private func setupCollectionView() {
		collectionView.dataSource = dataSource
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Self.cellReuseIdentifier)
	}
	
	private func setupSearchController() {
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = .ui.imagesSearchBarPlaceholder
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
	}
	
	// MARK: Actions
	
	func didRefresh() {
		dataSource.images = [
			UIImage(named: "image1")!, UIImage(named: "image1")!, UIImage(named: "image1")!,
			UIImage(named: "image1")!, UIImage(named: "image1")!, UIImage(named: "image1")!,
			UIImage(named: "image1")!, UIImage(named: "image1")!, UIImage(named: "image1")!,
			UIImage(named: "image1")!, UIImage(named: "image1")!, UIImage(named: "image1")!,
			UIImage(named: "image1")!, UIImage(named: "image1")!, UIImage(named: "image1")!,
		]
		collectionView.reloadData()
	}
		
	// MARK: Connivence
	
	fileprivate func filterContentForSearchText(_ searchText: String) {
		dataSource.filteredImages = dataSource.images.filter({( image: UIImage) -> Bool in
			return image.description.lowercased().contains(searchText.lowercased())
		})
		
		collectionView.reloadData()
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

// MARK: UISearchResultsUpdating
extension AlbumDetailsViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		filterContentForSearchText(searchController.searchBar.text ?? "")
	}
	
}
