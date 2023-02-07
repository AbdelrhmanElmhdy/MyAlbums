//
//  GenericError.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Foundation

enum GenericError: UserFriendlyError {
	case somethingWentWrong(description: String,
													userFriendlyDescription: String? = nil,
													userFriendlyAdvice: String? = nil,
													isFatal: Bool = false)
	
	var associatedValues: (description: String, userFriendlyDescription: String, userFriendlyAdvice: String, isFatal: Bool) {
		switch self {
		case let .somethingWentWrong(description, userFriendlyDescription, userFriendlyAdvice, isFatal):
			return (description,
							userFriendlyDescription ?? defaultUserFriendlyDescription,
							userFriendlyAdvice ?? defaultUserFriendlyAdvice,
							isFatal)
		}
	}
}
