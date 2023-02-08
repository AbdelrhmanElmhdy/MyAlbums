//
//  SettingsViewController+Actions.swift
//  This file was ported over from Connector project https://github.com/AbdelrhmanElmhdy/Connector
//
//  Created by Abdelrhman Elmahdy on 06/12/2022.
//

import UIKit

extension SettingsViewController: SettingsViewControllerProtocol { // + Actions
	
	func didSelectUserInterfaceStyle(_ style: UIUserInterfaceStyle?) {
		viewModel.selectUserInterfaceStyle(style)
	}
	
}
