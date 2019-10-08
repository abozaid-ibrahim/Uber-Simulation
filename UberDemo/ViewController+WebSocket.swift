//
//  ViewController+WebSocket.swift
//  UberDemo
//
//  Created by abuzeid on 10/8/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Starscream

extension ViewController: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
//        socket.write(string: "username")
    }

    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print(#function)
        statusLbl.backgroundColor = .red
        statusLbl.text = error?.localizedDescription
    }

    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print(#function)
//         1
        guard let data = text.data(using: .utf16),
            let jsonData = try? JSONSerialization.jsonObject(with: data),
            let jsonDict = jsonData as? [String: Any] else {
            return
        }

        do {
            let obj = try JSONDecoder().decode(EventRespose.self, from: data)
            self.data = obj

        } catch {
            print(error)
        }
        print(jsonDict)
    }

    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print(#function)
    }
}
