//
//  SocketManagerType.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/24/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import Foundation
import RxSwift

/// Indicates that a type manages a connection to a socket
protocol SocketManagerType: class {
	/// Connects to the socket
	///
	/// - Returns: an observable containing the booking events received
	func connect() -> Observable<BookingEvent>
}
