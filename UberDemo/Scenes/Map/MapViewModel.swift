//
//  MapViewModel.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/24/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import Foundation
import RxSwift
import Action
import RxSwiftExt

class MapViewModel: MapViewModelType {

	private let socketManager: SocketManagerType
	private let coordinator: MapCoordinatorType

	var pickupLocation: Observable<Location?> {
		return bookRide
			// observe the booking events emitted by the socket connection
			.elements
			// include only the events that affect the pickup location
			.filterMap { bookingEvent in
				switch bookingEvent {
				case .bookingOpened(let bookingInformation):
					// If a booking is opened then retrieve the pickup location from the booking information
					return .map(bookingInformation.pickupLocation)
				case .bookingClosed:
					// If the booking is closed then there's no longer a pickup location to be displayed
					return .map(nil)
				default:
					// ingore the other events
					return .ignore
				}
			}
			.startWith(nil)
	}

	var dropOffLocation: Observable<Location?> {
		return bookRide
			// observe the booking events emitted by the socket connection
			.elements
			// include only the events that affect the drop off location
			.filterMap { bookingEvent in
				switch bookingEvent {
				case .bookingOpened(let bookingInformation):
					// If a booking is opened then retrieve the drop off location from the booking information
					return .map(bookingInformation.dropoffLocation)
				case .bookingClosed:
					// If the booking is closed then there's no longer a drop off location to be displayed
					return .map(nil)
				default:
					// ingore the other events
					return .ignore
				}
			}
			.startWith(nil)
	}

	var vehicleLocation: Observable<Location?> {
		return bookRide
			// observe the booking events emitted by the socket connection
			.elements
			// include only the events that affect the vehicle's location
			.filterMap { bookingEvent -> FilterMap<Location?> in
				switch bookingEvent {
				case .bookingOpened(let bookingInformation):
					// If a booking is opened then retrieve the initial vehicle location from the booking information
					return .map(bookingInformation.vehicleLocation)
				case .vehicleLocationUpdated(let vehicleLocation):
					// When the vehicle's location is updated then retrieve it's current location
					return .map(vehicleLocation)
				case .bookingClosed:
					// If the booking is closed then there's no longer a vehicle's location to be displayed
					return .map(nil)
				default:
					// ingore the other events
					return .ignore
				}
			}
			// Include the previous location in order to calculate the bearing of the vehicle
			// Start with the previous location is nil
			.scan(nil) { (previousVehicleLocation, currentVehicleLocation) -> Location? in
				var currentVehicleLocation = currentVehicleLocation
				currentVehicleLocation?.setBearingRelative(to: previousVehicleLocation)
				return currentVehicleLocation
			}
			.startWith(nil)
	}

	var intermediateStopLocations: Observable<[Location]> {
		return bookRide
			// observe the booking events emitted by the socket connection
			.elements
			// include only the events that affect the intermediate stop locations
			.filterMap { (bookingEvent) in
				switch bookingEvent {
				case .bookingOpened(let bookingInformation):
					// If a booking is opened then retrieve the initial intermediate stop locations from the booking information
					return .map(bookingInformation.intermediateStopLocations)
				case .intermediateStopLocationsChanged(let intermediateStopLocations):
					// Whenever the intermediate stop locations are updated then retrieve them
					return .map(intermediateStopLocations)
				case .bookingClosed:
					// If the booking is closed then there's no longer any intermediate stop locations to be displayed
					return .map([])
				default:
					// ingore the other events
					return .ignore
				}
			}
			.startWith([])
	}

	var bookingStatus: Observable<BookingStatus?> {
		return bookRide
			// observe the booking events emitted by the socket connection
			.elements
			// include only the events that affect the booking status
			.filterMap { bookingEvent in
				switch bookingEvent {
				case .bookingOpened(let bookingInformation):
					// If a booking is opened then retrieve the initial status from the booking information
					return .map(bookingInformation.status)
				case .statusUpdated(let bookingStatus):
					// Whenever the status is updated then retrieve it
					return .map(bookingStatus)
				case .bookingClosed:
					// If the booking is closed then there's no longer a status to be displayed
					return .map(nil)
				default:
					// ingore the other events
					return .ignore
				}
			}
			.startWith(nil)
	}

	lazy var bookRide: Action<Void, BookingEvent> = generateAction()

	/// Creates and returns a new view model with provided dependencies
	/// - Parameter socketManager: The socket manager that will provide the
	/// - Parameter coordinator: The coordinator that will handle the coordination between the other modules
	init(socketManager: SocketManagerType, coordinator: MapCoordinatorType) {
		self.socketManager = socketManager
		self.coordinator = coordinator
	}

	/// Generates the action that will trigger the connection with the socket manager
	func generateAction() -> Action<Void, BookingEvent> {
		return Action { [socketManager] in
			socketManager.connect()
		}
	}
}
