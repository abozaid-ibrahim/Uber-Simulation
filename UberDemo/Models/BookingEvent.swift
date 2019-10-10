//
//  BookingEvent.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/24/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import Foundation

/// The types of events triggered when there's an update in the booking
///
/// - bookingOpened: Indicates that a booking has been opened with the associated booking information
/// - vehicleLocationUpdated: Indicates that the vehicle's location has changed
/// - statusUpdated: Indicates that the status of the booking has changed to the associated booking status
/// - intermediateStopLocationsChanged: Indicates that the intermediate stops have changed
/// - bookingClosed: Indicates that the booking has been closed
enum BookingEvent {
	case bookingOpened(BookingInformation)
	case vehicleLocationUpdated(Location)
	case statusUpdated(BookingStatus)
	case intermediateStopLocationsChanged([Location])
	case bookingClosed
}

extension BookingEvent: Decodable {

	enum CodingKeys: String, CodingKey {
		case event
		case data
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let eventName = try container.decode(String.self, forKey: .event)

		switch eventName {
		case "bookingOpened":
			self = .bookingOpened(try container.decode(BookingInformation.self, forKey: .data))
		case "vehicleLocationUpdated":
			self = .vehicleLocationUpdated(try container.decode(Location.self, forKey: .data))
		case "statusUpdated":
			self = .statusUpdated(try container.decode(BookingStatus.self, forKey: .data))
		case "intermediateStopLocationsChanged":
			self = .intermediateStopLocationsChanged(try container.decode([Location].self, forKey: .data))
		case "bookingClosed":
			self = .bookingClosed
		default:
			self = .bookingClosed
		}
	}
}
