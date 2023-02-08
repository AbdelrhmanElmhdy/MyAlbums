//
//  PresentsToast.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import UIKit

protocol PresentsToast: UIViewController, ToastDelegate {
	var toastView: ToastView { get set }
	
	func presentToast(withTitle title: String, andDescription description: String, animated: Bool)
	func dismissToast(animated: Bool)
}

extension PresentsToast {
	private func setupToast() {
		toastView.delegate = self
		
		let window = SceneDelegate.shared.window!
		window.addSubview(toastView)
		toastView.translatesAutoresizingMaskIntoConstraints = false
		
		let bottomPadding = 15.0
		let bottomAnchorConstraintConstant: CGFloat
		
		// If the view controller has a tabBarController and does not hide it, constraint the toast's bottom anchor to the tabBar's top anchor.
		if let tabBarController = tabBarController, !hidesBottomBarWhenPushed {
			bottomAnchorConstraintConstant = tabBarController.tabBar.frame.height + bottomPadding
		} else { // Else constraint the toast's bottom anchor to the window's bottom anchor.
			bottomAnchorConstraintConstant = window.safeAreaInsets.bottom + bottomPadding
		}
		
		NSLayoutConstraint.activate([
			toastView.leadingAnchor.constraint(equalTo: window.safeAreaLayoutGuide.leadingAnchor),
			toastView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -bottomAnchorConstraintConstant),
			toastView.trailingAnchor.constraint(equalTo: window.safeAreaLayoutGuide.trailingAnchor),
		])
		
	}
	
	private func removeToastFromSuperview() {
		toastView.removeFromSuperview()
	}
	
	func presentToast(withTitle title: String, andDescription description: String = "", animated: Bool) {
		if toastView.superview == nil {
			setupToast()
		}
		toastView.present(withTitle: title, andDescription: description, animated: animated)
	}
	
	func dismissToast(animated: Bool) {
		toastView.dismiss(animated: animated, completion: { [weak self] _ in self?.removeToastFromSuperview() })
	}
	
	func didPresent(_ toastView: ToastView) {
		
	}
	
	func didDismiss(_ toastView: ToastView) {
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
