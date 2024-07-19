//
//  Rick_MortyApp.swift
//  Rick&Morty
//
//  Created by Artem Rodionov on 17.07.2024.
//

import SwiftUI

@main
struct Rick_MortyApp: App {
    var body: some Scene {
        WindowGroup {
            RNMainView(
                viewModel: RNMViewModel(
                    api: CombineApi(),
                    manager: NetworkMonitor()
                )
            )
            .environment(\.colorScheme, .dark)
        }
    }
}

