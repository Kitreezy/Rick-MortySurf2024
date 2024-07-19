//
//  ServerApi.swift
//  Rick&Morty
//
//  Created by Artem Rodionov on 18.07.2024.
//

import Foundation
import Combine

protocol ServerApi {
    
    func getCharacterData() -> AnyPublisher<[RNMCharacterModel], Never>
    
    func getEpisodeData() -> AnyPublisher<[RNMEpisodeModel], Never>
}
