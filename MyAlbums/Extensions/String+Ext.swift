//
//  String+Ext.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import Foundation

// MARK: + Utilities

extension String {
	var localized: String { NSLocalizedString(self, comment: "") }
}

// MARK: + Static Texts

extension String {
	static let ui = UITextsContainer.self
	static let errors = ErrorTextsContainer.self
}
