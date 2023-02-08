//
//  SettingsViewModel.swift
//  This file was ported over from Connector project https://github.com/AbdelrhmanElmhdy/Connector
//
//  Created by Abdelrhman Elmahdy on 28/11/2022.
//

import UIKit

class SettingsViewModel {
	private let userPreferencesService: UserPreferencesService
	
	init(userPreferencesService: UserPreferencesService) {
		self.userPreferencesService = userPreferencesService
	}
	
	func selectUserInterfaceStyle(_ selectedStyle: UIUserInterfaceStyle?) {
		guard let selectedStyle = selectedStyle else { return }
		userPreferencesService.updateUserInterfaceStyle(with: selectedStyle)
		
		guard let window = UIApplication.shared.keyWindow else { return }
		
		UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve) {
			window.overrideUserInterfaceStyle = selectedStyle
		}
		
	}
	
}
