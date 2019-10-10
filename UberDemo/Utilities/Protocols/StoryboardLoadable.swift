//
//  StoryboardLoadable.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/20/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import Foundation
import UIKit

/// Indicates that the type can be loaded from a storyboard
protocol StoryboardLoadable: class {
	/// The name of the storyboard
	static var storyboardName: String { get }
	/// The identifier of the type inside the storyboard
	static var storyboardIdentifier: String { get }
}

extension StoryboardLoadable where Self: UIViewController {

	static var storyboardName: String {
		return String(describing: self)
	}

	static var storyboardIdentifier: String {
		return String(describing: self)
	}

	static func instantiateFromStoryboard() -> Self {
		return Storyboard(name: storyboardName).instatiate(Self.self)
	}
}
