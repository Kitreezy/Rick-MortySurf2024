//
//  NetworkMonitor.swift
//  Rick&Morty
//
//  Created by Artem Rodionov on 18.07.2024.
//

import Foundation
import Network

class NetworkMonitor: WiFiManager {
    var callback: ((Bool) -> Void)?
    
    private let monitor = NWPathMonitor()
    
    init() {
        monitor.pathUpdateHandler = onUpdate
    }
    
    func start() {
        monitor.start(queue: DispatchQueue.main)
    }
    
    private func onUpdate(path: NWPath) {
        callback?(path.status == .satisfied)
    }
}
