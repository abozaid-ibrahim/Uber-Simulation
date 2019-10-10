//
//  AppDelegate.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/20/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	lazy var coordinator: Coordinator = {
		AppCoordinator(window: self.window)
	}()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		self.window = UIWindow(frame: UIScreen.main.bounds)
		coordinator.start {
			self.window?.makeKeyAndVisible()
		}
		return true
	}
}
