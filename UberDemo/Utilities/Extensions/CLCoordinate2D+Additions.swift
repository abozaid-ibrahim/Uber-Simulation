//
//  CLCoordinate2D+Additions.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/24/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
	/// Convenience initializer to convert from the `Location` model
	///
	/// - Parameter location: The `Location` model
	init(location: Location) {
		self.init(latitude: location.latitude, longitude: location.longitude)
	}
}
