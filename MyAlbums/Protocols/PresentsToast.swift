//
//  PresentsToast.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import UIKit

protocol PresentsToast: UIViewController, ToastDelegate {
	var toast: Toast { get set }
	
	func presentToast(withTitle title: String, andDescription description: String, animated: Bool)
	func dismissToast(animated: Bool)
}

extension PresentsToast {
	private func setupToast() {
		toast.delegate = self
		
		let window = SceneDelegate.shared.window!
		window.addSubview(toast)
		toast.translatesAutoresizingMaskIntoConstraints = false
		
		let bottomPadding = 15.0
		let bottomAnchorConstraintConstant: CGFloat
		
		// If the view controller has a tabBarController and does not hide it, constraint the toast's bottom anchor to the tabBar's top anchor.
		if let tabBarController = tabBarController, !hidesBottomBarWhenPushed {
			bottomAnchorConstraintConstant = tabBarController.tabBar.frame.height + bottomPadding
		} else { // Else constraint the toast's bottom anchor to the window's bottom anchor.
			bottomAnchorConstraintConstant = window.safeAreaInsets.bottom + bottomPadding
		}
		
		NSLayoutConstraint.activate([
			toast.leadingAnchor.constraint(equalTo: window.safeAreaLayoutGuide.leadingAnchor),
			toast.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -bottomAnchorConstraintConstant),
			toast.trailingAnchor.constraint(equalTo: window.safeAreaLayoutGuide.trailingAnchor),
		])
		
	}
	
	private func removeToastFromSuperview() {
		toast.removeFromSuperview()
	}
	
	func presentToast(withTitle title: String, andDescription description: String = "", animated: Bool) {
		if toast.superview == nil {
			setupToast()
		}
		toast.present(withTitle: title, andDescription: description, animated: animated)
	}
	
	func dismissToast(animated: Bool) {
		toast.dismiss(animated: animated, completion: { [weak self] _ in self?.removeToastFromSuperview() })
	}
	
	func didPresent(_ toast: Toast) {
		
	}
	
	func didDismiss(_ toast: Toast) {
		removeToastFromSuperview()
	}
}

extension UIApplication {
	
	var keyWindow: UIWindow? {
		// Get connected scenes
		return UIApplication.shared.connectedScenes
		// Keep only active scenes, onscreen and visible to the user
			.filter { $0.activationState == .foregroundActive }
		// Keep only the first `UIWindowScene`
			.first(where: { $0 is UIWindowScene })
		// Get its associated windows
			.flatMap({ $0 as? UIWindowScene })?.windows
		// Finally, keep only the key window
			.first(where: \.isKeyWindow)
	}
	
}
