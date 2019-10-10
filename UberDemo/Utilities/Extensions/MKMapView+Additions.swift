//
//  MKMapView+Additions.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/24/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
	/// Fits all the annotations in the map
	///
	/// - Parameter animated: animate the change
	func fitAll(animated: Bool) {
		var zoomRect = MKMapRect.null
		for annotation in annotations {
			let annotationPoint = MKMapPoint(annotation.coordinate)
			let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01)
			zoomRect = zoomRect.union(pointRect)
		}
		setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 64, left: 64, bottom: 64, right: 64), animated: animated)
	}

	func register<AnnotationView>(_ annotationViewClass: AnnotationView.Type) where AnnotationView: Reusable {
		register(annotationViewClass, forAnnotationViewWithReuseIdentifier: annotationViewClass.reuseIdentifier)
	}

	func dequeueReusableAnnotationView<AnnotationView: MKAnnotationView>(for annotation: MKAnnotation) -> AnnotationView where AnnotationView: Reusable {
		guard let annotationView = self.dequeueReusableAnnotationView(withIdentifier: AnnotationView.reuseIdentifier, for: annotation) as? AnnotationView else {
			fatalError("Unable to dequeue annotation view with identifier \(AnnotationView.reuseIdentifier) of type \(AnnotationView.self)")
		}
		return annotationView
	}
}
