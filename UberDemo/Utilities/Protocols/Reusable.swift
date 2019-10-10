//
//  Reusable.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 10/3/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import UIKit
import MapKit

/// Declares that a type acts as a reusable components and provides a reuse identifier
protocol Reusable: class {
	static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
	static var reuseIdentifier: String {
		return String(describing: Self.self)
	}
}

extension MKMarkerAnnotationView: Reusable { }
