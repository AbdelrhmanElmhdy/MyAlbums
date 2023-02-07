//
//  UIRefreshControl+Ext.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import UIKit

extension UIRefreshControl {
	func programmaticallyBeginRefreshing(in scrollView: UIScrollView) {
		beginRefreshing()
		let offsetPoint = CGPoint.init(x: 0, y: -frame.size.height)
		scrollView.setContentOffset(offsetPoint, animated: true)
	}
}
