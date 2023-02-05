//
//  ProfileViewController.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import UIKit

class ProfileViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		title = .ui.profile
		view.backgroundColor = .systemBackground
	}


}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ProfileViewController_Preview: PreviewProvider {
	static var previews: some View {
		ForEach(DEVICE_NAMES, id: \.self) { deviceName in
			UIViewControllerPreview {
				AppDelegate.shared.viewControllersFactory.makeProfileViewController(for: ProfileCoordinatorMock())
			}.previewDevice(PreviewDevice(rawValue: deviceName))
				.previewDisplayName(deviceName)
		}
	}
}
#endif
