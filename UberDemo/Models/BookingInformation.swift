//
//  BookingInformation.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/24/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import Foundation

/// The information of the booking
struct BookingInformation: Decodable {

	enum CodingKeys: String, CodingKey {
		case status
		case vehicleLocation
		case pickupLocation
		case dropoffLocation
		case intermediateStopLocations
	}

	let status: BookingStatus
	let vehicleLocation: Location
	let pickupLocation: Location
	let dropoffLocation: Location
	let intermediateStopLocations: [Location]
}
