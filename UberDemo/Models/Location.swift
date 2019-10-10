//
//  Location.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/24/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import Foundation

/// Contains the address and coordinates of a location
/// Also has a bearing property which is default `nil` but is set when providing another location relative to that one
struct Location: Decodable {

	enum CodingKeys: String, CodingKey {
		case address
		case longitude = "lng"
		case latitude = "lat"
	}

	let address: String?
	let longitude: Double
	let latitude: Double
	var bearing: Double?
}

extension Location {

	mutating func setBearingRelative(to otherLocation: Location?) {
		guard let otherLocation = otherLocation else {
			bearing = nil
			return
		}

		let lat1 = otherLocation.latitude.toRadians()
		let lon1 = otherLocation.longitude.toRadians()

		let lat2 = self.latitude.toRadians()
		let lon2 = self.longitude.toRadians()

		let deltaLon = lon2 - lon1

		bearing = atan2(sin(deltaLon) * cos(lat2), cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(deltaLon))
	}
}
