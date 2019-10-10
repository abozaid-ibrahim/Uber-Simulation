//
//  Double+Additions.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 10/2/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import Foundation

extension Double {
	/// Converts from degrees to radians
	///
	/// - Returns: the radians value
	func toRadians() -> Double {
		return self * .pi / 180.0
	}
}
