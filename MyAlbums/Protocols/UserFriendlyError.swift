//
//  UserFriendlyError.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Foundation

/// An error that can be used to present a user friendly error message to the user and some advice, while retaining the developer friendly description.
protocol UserFriendlyError: Error {
	
	var description: String { get }
	var userFriendlyDescription: String { get }
	var userFriendlyAdvice: String { get }
	var isFatal: Bool { get }
	
	var defaultUserFriendlyDescription: String { get }
	var defaultUserFriendlyAdvice: String { get }
	
	var associatedValues: (description: String, userFriendlyDescription: String, userFriendlyAdvice: String, isFatal: Bool) { get }
}

extension UserFriendlyError {
	
	var description: String {
		return "Error: " + associatedValues.description + Thread.callStackSymbols.joined(separator: "\n")
	}
	
	var userFriendlyDescription: String {
		return associatedValues.userFriendlyDescription
	}
	
	var userFriendlyAdvice: String {
		return associatedValues.userFriendlyAdvice
	}
	
	var isFatal: Bool {
		return associatedValues.isFatal
	}
	
	var defaultUserFriendlyDescription: String {
		return .errors.somethingWentWrong
	}
	
	var defaultUserFriendlyAdvice: String {
		return .errors.tryAgainLater
	}
	
}
