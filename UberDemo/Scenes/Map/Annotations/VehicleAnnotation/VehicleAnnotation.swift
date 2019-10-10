//
//  VehicleAnnotation.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 10/2/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import MapKit

class VehicleAnnotation: MKPointAnnotation {

	/// reference to the annotation view for callbacks when the bearing changes
	weak var annotationView: VehicleAnnotationView?

	/// The current bearing of the annotation
	var bearing: Double? {
		didSet {
			annotationView?.bearing = bearing
		}
	}
}
