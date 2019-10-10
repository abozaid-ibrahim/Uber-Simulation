//
//  Coordinator.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/20/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import Foundation

/// Decalres that type works as a Coordinator
protocol Coordinator: class {
	/// Starts the coordinator
	///
	/// - Parameter completion: completion handler called after the coordinator has started
	func start(completion: (() -> Void)?)
	/// Finishes the coordinator
	///
	/// - Parameter completion: completion handler called after the coordinator has finished
	func finish(completion: (() -> Void)?)
}

extension Coordinator {
	func start() {
		start(completion: nil)
	}

	func finish() {
		finish(completion: nil)
	}
}
