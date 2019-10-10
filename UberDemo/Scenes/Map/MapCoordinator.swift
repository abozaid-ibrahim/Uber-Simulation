//
//  MapCoordinator.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/24/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import UIKit

class MapCoordinator: MapCoordinatorType {

	private weak var rootNavigationController: UINavigationController?

	/// Creates and returns a new coordinator
	///
	/// - Parameter rootNavigationController: The root navigation controller
	init(rootNavigationController: UINavigationController?) {
		self.rootNavigationController = rootNavigationController
	}

	func start(completion: (() -> Void)?) {
		guard let rootNavigationController = rootNavigationController else { completion?(); return }
		let socketManager = SocketManager()
		let viewModel = MapViewModel(socketManager: socketManager, coordinator: self)
		let viewController = MapViewController.instantiateFromStoryboard()
		viewController.viewModel = viewModel
		rootNavigationController.setViewControllers([viewController], animated: false)
		completion?()
	}

	func finish(completion: (() -> Void)?) {
		completion?()
	}
}
