//
//  SettingsViewController.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

class SettingsViewController: UITableViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		title = .ui.settings
		view.backgroundColor = .systemGroupedBackground
	}
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct SettingsViewController_Preview: PreviewProvider {
	static var previews: some View {
		ForEach(DEVICE_NAMES, id: \.self) { deviceName in
			UIViewControllerPreview {
				AppDelegate.shared.viewControllersFactory.makeSettingsViewController(for: SettingsStackCoordinatorMock(),
																																						 settingsSections: [])
			}.previewDevice(PreviewDevice(rawValue: deviceName))
				.previewDisplayName(deviceName)
		}
	}
}
#endif
