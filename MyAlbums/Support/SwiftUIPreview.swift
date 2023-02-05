//
//  SwiftUIPreview.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import Foundation

#if canImport(SwiftUI) && DEBUG
import SwiftUI

let DEVICE_NAMES: [String] = [
	"iPhone 14 Pro Max",
	"iPhone SE (3rd generation)"
]

struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
	let viewController: ViewController
	
	init(_ builder: @escaping () -> ViewController) {
		viewController = builder()
	}
	
	// MARK: - UIViewControllerRepresentable
	func makeUIViewController(context: Context) -> ViewController {
		viewController
	}
	
	func updateUIViewController(_ uiViewController: ViewController, context: UIViewControllerRepresentableContext<UIViewControllerPreview<ViewController>>) {
		return
	}
}
#endif
