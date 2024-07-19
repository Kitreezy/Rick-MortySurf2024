//
//  RNMEpisodeModel.swift
//  Rick&Morty
//
//  Created by Artem Rodionov on 19.07.2024.
//

import Foundation

struct RNMEpisodeModel: Codable, Identifiable, Hashable {
    let id: Int?
    let name: String?
    let episode: String?
}
