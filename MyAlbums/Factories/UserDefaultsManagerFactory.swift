//
//  UserDefaultsManagerFactory.swift
//  This file was ported over from Connector project https://github.com/AbdelrhmanElmhdy/Connector
//
//  Created by Abdelrhman Elmahdy on 11/12/2022.
//

import Foundation

class UserDefaultsManagerFactory {
	
	static func make(context: ENV.Context? = nil) -> UserDefaultsManagerProtocol {
		let context = context ?? ENV.context
		return context == .test ? UserDefaultsManagerMock() : UserDefaultsManager()
	}
	
}
