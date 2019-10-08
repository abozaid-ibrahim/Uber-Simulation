//
//  EventApiResponse.swift
//  UberDemo
//
//  Created by abuzeid on 10/8/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - QuarterRespose

public struct EventRespose: Codable {
    public let event: String?
    public let data: PickupData?

    enum CodingKeys: String, CodingKey {
        case event
        case data
    }

    public init(event: String?, data: PickupData?) {
        self.event = event
        self.data = data
    }
}

// MARK: - DataClass

public struct PickupData: Codable {
    public let status: String?
    public let vehicleLocation: Location?
    public let pickupLocation: Location?
    public let dropoffLocation: Location?
    public let intermediateStopLocations: [Location]?

    enum CodingKeys: String, CodingKey {
        case status
        case vehicleLocation
        case pickupLocation
        case dropoffLocation
        case intermediateStopLocations
    }

    public init(status: String?, vehicleLocation: Location?, pickupLocation: Location?, dropoffLocation: Location?, intermediateStopLocations: [Location]?) {
        self.status = status
        self.vehicleLocation = vehicleLocation
        self.pickupLocation = pickupLocation
        self.dropoffLocation = dropoffLocation
        self.intermediateStopLocations = intermediateStopLocations
    }
}

// MARK: - Location

public struct Location: Codable {
    public let address: String?
    public let lng: Double?
    public let lat: Double?

    enum CodingKeys: String, CodingKey {
        case address
        case lng
        case lat
    }

    public init(address: String?, lng: Double?, lat: Double?) {
        self.address = address
        self.lng = lng
        self.lat = lat
    }
}
