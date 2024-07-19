//
//  RNMCharacterModel.swift
//  Rick&Morty
//
//  Created by Artem Rodionov on 18.07.2024.
//

import SwiftUI
// MARK: - Character Model
struct RNMCharacterModel: Codable, Identifiable, Hashable {
    let id: Int?
    let name: String?
    let status: Status?
    let species: String?
    let gender: String?
    let origin, location: RickNMortyLocationModel?
    let image: String?
    let episode: [String]?
}
// MARK: - Origin&Location Model
struct RickNMortyLocationModel: Codable, Hashable {
    let name: String
    let url: String
}

// MARK: - Status
enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
// MARK: - Status Color
extension Status {
    var statusColor: Color {
        switch self {
        case .alive:
            return .green
        case .dead:
            return .red
        case .unknown:
            return .gray
        }
    }
}
// MARK: - Mock model
extension RNMCharacterModel {
    static let someCharacter: RNMCharacterModel  =
    RNMCharacterModel(id: 1, name: "Rick", status: .alive, species: "Human", gender: "Male", origin: .init(name: "", url: ""), location: .init(name: "Earth", url: ""), image: "", episode: [])
    
}
