//
//  ToastDelegate.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 08/02/2023.
//

import Foundation

protocol ToastDelegate {
	func didPresent(_ toastView: ToastView)
	func didDismiss(_ toastView: ToastView)
}
