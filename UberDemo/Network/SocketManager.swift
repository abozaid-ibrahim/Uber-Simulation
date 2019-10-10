//
//  SocketManager.swift
//  UberSimulation
//
//  Created by Abuzeid ibrahim on 9/24/19.
//  Copyright © 2019 Abuzeid Mac. All rights reserved.
//

import Foundation
import Starscream
import RxSwift

class SocketManager: SocketManagerType {

	func connect() -> Observable<BookingEvent> {
		return Observable.create { (observer) -> Disposable in
			// create a new socket
			let socket = WebSocket(url: URL(string: "wss://d2d-frontend-code-challenge.herokuapp.com")!)

			// When the socket is disconnected
			socket.onDisconnect = { error in
				if let error = error {
					// If it's because of an error then forward that to the observer
					observer.onError(error)
				} else {
					// Else the connection has been completed successfully
					observer.onCompleted()
				}
			}

			// Whenever text is received
			socket.onText = { message in
				// convert it to data
				guard let data = message.data(using: .utf16) else { return }
				do {
					// try and parse the booking event from it
					observer.onNext(try JSONDecoder().decode(BookingEvent.self, from: data))
				} catch {
					// Else send the parsing error to the observer
					observer.onError(error)
				}
			}

			// Whenever data is received
			socket.onData = { data in
				do {
					// try and parse the booking event from it
					observer.onNext(try JSONDecoder().decode(BookingEvent.self, from: data))
				} catch {
					// Else send the parsing error to the observer
					observer.onError(error)
				}
			}

			// connect to the socket
			socket.connect()

			return Disposables.create {
				// dispose of the connection
				socket.disconnect()
			}
		}
	}
}
