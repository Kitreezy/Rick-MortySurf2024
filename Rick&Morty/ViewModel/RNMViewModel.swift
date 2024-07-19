//
//  RickNMortyViewModel.swift
//  Rick&Morty
//
//  Created by Artem Rodionov on 18.07.2024.
//

import Foundation
import SwiftUI
import Network
import Combine

class RNMViewModel: ObservableObject {
// MARK: - Published property
    @Published var loadedCharacters: [RNMCharacterModel] = []
    @Published var loadedEpisode: [RNMEpisodeModel] = []
    @Published var isConnected = true
    
// MARK: - API & WiFi manager property
    private let api: ServerApi
    private var manager: WiFiManager
// MARK: - Store property
    private var disposeCharacter: Set<AnyCancellable> = []
    private var disposeEpisode: Set<AnyCancellable> = []
// MARK: - init ViewModel
    init(api: ServerApi, manager: WiFiManager) {
        self.api = api
        self.manager = manager
        
        self.manager.callback = onPathUpdate
        self.manager.start()
    }
    
// MARK: - Search/Filter Methods

    
// MARK: - Private Methods
    private func onPathUpdate(status: Bool) {
        isConnected = status
        if isConnected {
             refreshCharacterData()
             refreshEpisodeData()
        } else {
            loadedCharacters = []
        }
    }
    
    private func refreshCharacterData() {
        api.getCharacterData()
            .receive(on: DispatchQueue.main)
            .sink { character in
                self.loadedCharacters = character
            }
            .store(in: &disposeCharacter)
    }
    
    private func refreshEpisodeData() {
        api.getEpisodeData()
            .receive(on: DispatchQueue.main)
            .sink { episode in
                self.loadedEpisode = episode
            }
            .store(in: &disposeEpisode)
    }
}

