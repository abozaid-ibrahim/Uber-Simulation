//
//  AppCoordinator.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/20/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import Foundation
import UIKit

/// The App Coordinator creates the The Root ViewController of the Window
class AppCoordinator: Coordinator {

	weak var window: UIWindow?

	private(set) weak var rootNavigationController: UINavigationController?

	/// Creates a new instance of the App Coordinator
	///
	/// - Parameter window: The main widnow of the application
	init(window: UIWindow?) {
		self.window = window
	}

	func start(completion: (() -> Void)?) {
		guard let window = self.window else { completion?(); return }

		let rootNavigationController = UINavigationController()
		self.rootNavigationController = rootNavigationController
		rootNavigationController.isNavigationBarHidden = true

		MapCoordinator(rootNavigationController: rootNavigationController).start {
			window.rootViewController = rootNavigationController
			completion?()
		}
	}

	func finish(completion: (() -> Void)?) {
		completion?()
	}
}
