//
//  CombineApi.swift
//  Rick&Morty
//
//  Created by Artem Rodionov on 18.07.2024.
//

import Foundation
import Combine

struct CombineApi: ServerApi {
    func getCharacterData() -> AnyPublisher<[RNMCharacterModel], Never> {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://rickandmortyapi.com/api/character")!)
            .map { $0.data }
            .decode(type: RNMCharacterResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    func getEpisodeData() -> AnyPublisher<[RNMEpisodeModel], Never> {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://rickandmortyapi.com/api/episode")!)
            .map { $0.data }
            .decode(type: RNMEpisodeResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}

