//
//  CellFrames.swift
//  Rick&Morty
//
//  Created by Artem Rodionov on 17.07.2024.
//

import SwiftUI

struct CellFrames: Equatable {
    var frames: [RNMCharacterModel: CGRect] = [:]
}

extension CellFrames: PreferenceKey {
    static var defaultValue: Self { .init() }
    static func reduce(value: inout Self, nextValue: () -> Self) {
        value.frames.merge(nextValue().frames) { $1 }
    }
}
