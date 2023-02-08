//
//  ToastDelegate.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 08/02/2023.
//

import Foundation

protocol ToastDelegate {
	func didPresent(_ toast: Toast)
	func didDismiss(_ toast: Toast)
}
