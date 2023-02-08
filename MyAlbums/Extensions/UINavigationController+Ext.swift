//
//  UINavigationController+Ext.swift
//  This file was ported over from Connector project https://github.com/AbdelrhmanElmhdy/Connector
//
//  Created by Abdelrhman Elmahdy on 26/11/2022.
//

import UIKit

extension UINavigationController {
	
	var previousViewController: UIViewController? {
		guard viewControllers.count >= 2 else {
			return nil
		}
		
		let previousVCIndex = viewControllers.count - 2
		let previousVC = viewControllers[previousVCIndex]
		
		return previousVC
	}
	
}
