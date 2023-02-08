//
//  ErrorManager.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 08/02/2023.
//

import Foundation

struct ErrorManager {
	
	// TODO: report error through to a crashlytics system
	/// - Stub
	static func reportError(_ error: Error) {
		print("ERROR: " + error.localizedDescription)
	}
	
}
