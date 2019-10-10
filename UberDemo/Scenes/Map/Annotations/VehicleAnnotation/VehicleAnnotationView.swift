//
//  VehicleAnnotationView.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 10/3/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import MapKit

/// Custom AnnotationView that displays the vehicle's image and its bearing
class VehicleAnnotationView: MKAnnotationView {

	private lazy var imageView: UIImageView = {
		UIImageView(image: UIImage(named: "car-icon"))
	}()

	/// The current bearing of the vehicle
	var bearing: Double? {
		didSet {
			imageView.transform = CGAffineTransform.identity.rotated(by: CGFloat(bearing ?? 0))
		}
	}

	override var annotation: MKAnnotation? {
		didSet {
			if let vehicleAnnotation = annotation as? VehicleAnnotation {
				bearing = vehicleAnnotation.bearing
				vehicleAnnotation.annotationView = self
			}
		}
	}

	override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
		setup()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}

	private func setup() {
		addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
		])

		if let vehicleAnnotation = annotation as? VehicleAnnotation {
			bearing = vehicleAnnotation.bearing
			vehicleAnnotation.annotationView = self
		}
	}
}

extension VehicleAnnotationView: Reusable { }

