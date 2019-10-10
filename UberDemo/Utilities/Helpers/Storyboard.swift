//
//  Storyboard.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/20/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import Foundation
import UIKit

/// Wrapper around UIStoryboard
struct Storyboard {
	/// The name of the storyboard
	let name: String

	/// The instance of UIStoryboard
	var instance: UIStoryboard {
		return UIStoryboard(name: self.name, bundle: nil)
	}

	/// Instantiates a ViewController of the provided type from the storyboard instance
	///
	/// - Parameter type: The expected type of the ViewController
	/// - Returns: an instance of the ViewController created
	func instatiate<T: UIViewController>(_: T.Type) -> T where T: StoryboardLoadable {
		guard let viewController = self.instance.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
			fatalError("unable to instantiate ViewController of type \(T.self) from storyboard with name \(self.name)")
		}
		return viewController
	}
}
