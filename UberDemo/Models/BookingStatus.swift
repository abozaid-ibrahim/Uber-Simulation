//
//  BookingStatus.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/24/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import Foundation

/// The status of the booking
enum BookingStatus: String, Decodable {
	case waitingForPickup
	case inVehicle
	case droppedOff
}

extension BookingStatus {
	var displayText: String {
		switch self {
		case .waitingForPickup:
			return "Waiting for Pickup"
		case .inVehicle:
			return "In Vehicle"
		case .droppedOff:
			return "Dropped Off"
		}
	}
}
