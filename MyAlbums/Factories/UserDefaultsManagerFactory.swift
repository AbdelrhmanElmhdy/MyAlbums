//
//  UserDefaultsManagerFactory.swift
//  This file was ported over from Connector project https://github.com/AbdelrhmanElmhdy/Connector
//
//  Created by Abdelrhman Elmahdy on 11/12/2022.
//

import Foundation

class UserDefaultsManagerFactory {
	static func make() -> UserDefaultsManagerProtocol {
		return ENV.context == .test ? UserDefaultsManagerMock() : UserDefaultsManager()
	}
}
