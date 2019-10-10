//
//  MapViewModelType.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/24/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import Foundation
import RxSwift
import Action

protocol MapViewModelType: class {
	/// Observable containing the current pickup location
	/// sends nil if the booking status is closed
	var pickupLocation: Observable<Location?> { get }
	/// Observable containing the current drop off location
	/// sends nil if the booking status is closed
	var dropOffLocation: Observable<Location?> { get }
	/// Observable containing the vehicle's current location
	/// sends nil if the booking status is closed
	var vehicleLocation: Observable<Location?> { get }
	/// Observable containing the current intermediate stop location
	/// sends an empty array if the booking status is closed
	var intermediateStopLocations: Observable<[Location]> { get }
	/// Observable containing the current intermediate stop locations
	/// sends an empty array if the booking status is closed
	var bookingStatus: Observable<BookingStatus?> { get }
	/// Action to begin booking the ride
	var bookRide: Action<Void, BookingEvent> { get }
}
