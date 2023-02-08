//
//  NetworkRequestError.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Foundation
import Moya

enum NetworkRequestError : UserFriendlyError {
	init(moyaError: MoyaError) {
		switch moyaError.errorCode {
		case 6: self = .failedToConnectToInternet()
		// .
		// .
		// .
		// TODO: Add support for all relevant error codes.
		// .
		// .
		// .
		default: self = .somethingWentWrong(description: moyaError.localizedDescription)
		}
	}
	
	init(error: Error) {
		self = .somethingWentWrong(description: "\(type(of: error)): \(error.localizedDescription)")
	}
	
	case somethingWentWrong(description: String,
													userFriendlyDescription: String? = nil,
													userFriendlyAdvice: String? = nil,
													isFatal: Bool = true)
	
	case failedToConnectToInternet(description: String = "Failed to connect to internet",
																 userFriendlyDescription: String? = .errors.noInternetConnection,
																 userFriendlyAdvice: String? = .errors.checkInternetConnectionAdvice,
																 isFatal: Bool = false)
	
	case requestTimedOut(description: String = "Request timed out",
											 userFriendlyDescription: String? = .errors.noInternetConnection,
											 userFriendlyAdvice: String? = .errors.checkInternetConnectionAdvice,
											 isFatal: Bool = false)
	
	case failedToDecode(description: String,
											userFriendlyDescription: String? = nil,
											userFriendlyAdvice: String? = nil,
											isFatal: Bool = true)
	
	case failedToEncode(description: String,
											userFriendlyDescription: String? = nil,
											userFriendlyAdvice: String? = nil,
											isFatal: Bool = true)
	
	case httpResponseError(statusCode: Int)
	
	
	var associatedValues: (description: String, userFriendlyDescription: String, userFriendlyAdvice: String, isFatal: Bool) {
		switch self {
		case let .somethingWentWrong(description, userFriendlyDescription, userFriendlyAdvice, isFatal),
			let .failedToConnectToInternet(description, userFriendlyDescription, userFriendlyAdvice, isFatal),
			let .requestTimedOut(description, userFriendlyDescription, userFriendlyAdvice, isFatal),
			let .failedToDecode(description, userFriendlyDescription, userFriendlyAdvice, isFatal),
			let .failedToEncode(description, userFriendlyDescription, userFriendlyAdvice, isFatal):
			return (description,
							userFriendlyDescription ?? defaultUserFriendlyDescription,
							userFriendlyAdvice ?? defaultUserFriendlyAdvice,
							isFatal)
			
		case let .httpResponseError(statusCode):
			return getStatusCodeErrorAssociatedValues(statusCode)
		}
	}
	
	
	private func getStatusCodeErrorAssociatedValues(_ statusCode: Int)
	-> (description: String, userFriendlyDescription: String, userFriendlyAdvice: String, isFatal: Bool) {
		var statusCodeDescription = "statusCode: \(statusCode) "
		var userFriendlyDescription = defaultUserFriendlyDescription
		var userFriendlyAdvice: String = defaultUserFriendlyAdvice
		var isFatal = false
		
		switch statusCode {
		case 401:
			statusCodeDescription += "Authentication Required"
			userFriendlyDescription = .errors.loginRequired
			userFriendlyAdvice = .errors.loginAdvice
		case 403:
			statusCodeDescription += "Forbidden"
			userFriendlyDescription = .errors.noPermission
		case 408:
			statusCodeDescription += "Request Timeout"
			userFriendlyDescription = .errors.noInternetConnection
			userFriendlyAdvice = .errors.checkInternetConnectionAdvice
		case 401...500:
			statusCodeDescription += "Bad request"
			isFatal = true
		case 501...599:
			statusCodeDescription += "Server error"
		case 600:
			statusCodeDescription += "Outdated"
		default:
			statusCodeDescription += "Request failed"
		}
		
		return (statusCodeDescription, userFriendlyDescription, userFriendlyAdvice, isFatal)
	}
}
