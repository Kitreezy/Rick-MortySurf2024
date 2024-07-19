//
//  RNMCellCharacterView.swift
//  Rick&Morty
//
//  Created by Artem Rodionov on 17.07.2024.
//

import SwiftUI

struct RNMCellCharacterView: View {
// MARK: - Model propetry
    let character: RNMCharacterModel
// MARK: - Main Body View
    var body: some View {
        GroupBox {
            RickNMortyView(character: character)
        }
        .padding()
    }
}
// MARK: - Inside GropBox
struct RickNMortyView: View {
    let character: RNMCharacterModel
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: character.image ?? "")) { image in
                    image.image?.resizable()
                }
                .frame(width: Constants.imageFrameWidth,
                       height: Constants.imageFrameHeight)
                .clipShape(.rect(cornerRadius: Constants.imageClipShape))
                VStack(alignment: .leading, spacing: 2) {
                    Text(character.name ?? "")
                        .lineLimit(1)
                        .foregroundStyle(.white)
                        .font(.headline.monospacedDigit())
                    HStack {
                        Text(character.status?.rawValue ?? "")
                            .font(.footnote.bold())
                            .foregroundStyle(character.status?.statusColor ?? .clear)
                        Text("• \(character.species ?? "")")
                            .foregroundStyle(.cyan)
                            .font(.footnote.bold())
                    }
                    Text(character.gender ?? "")
                        .foregroundStyle(.white.opacity(0.5))
                        .font(.footnote.uppercaseSmallCaps())
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding(.bottom, Constants.bottomPaddingRNMView)
        }
    }
}

// MARK: - Nested Views


// MARK: - Nested types
private extension RickNMortyView {
    enum Constants {
        static let imageFrameWidth: CGFloat = 60
        static let imageFrameHeight: CGFloat = 60
        static let imageClipShape: CGFloat = 10
        static let bottomPaddingRNMView: CGFloat = 8
    }
}
// MARK: - Preview
struct CustomCell_Previews: PreviewProvider {
    static var character = RNMCharacterModel.someCharacter
    static var previews: some View {
        RNMCellCharacterView(character: character)
    }
}

