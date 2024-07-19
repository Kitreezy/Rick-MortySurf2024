//
//  WiFiManager.swift
//  Rick&Morty
//
//  Created by Artem Rodionov on 18.07.2024.
//

import Foundation

protocol WiFiManager {
    
    var callback: ((Bool) -> Void)? { get set }
    
    func start()
}
