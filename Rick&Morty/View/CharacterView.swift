//
//  CharacterView.swift
//  Rick&Morty
//
//  Created by Artem Rodionov on 19.07.2024.
//

import SwiftUI

struct CharacterView: View {
// MARK: - Property Wrappers
    @ObservedObject var viewModel: RNMViewModel
    @State var character: RNMCharacterModel
    @Environment(\.presentationMode) var presentationaMode
// MARK: - Main Body View
    var body: some View {
    GroupBox {
        RickNMortyCharacter(character: character)
    }
    .navigationBarBackButtonHidden(true)
    .toolbar {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                presentationaMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .foregroundStyle(.white)
            }
        }
        ToolbarItem(placement: .principal) {
            VStack {
                Text(character.name ?? "")
                    .font(.title2)
            }
        }
    }
    .padding(.top, Constants.paddingTopEquel)
    }
}
// MARK: - RNMChracter View
struct RickNMortyCharacter: View {
    let character: RNMCharacterModel
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.image ?? "")) { image in
                image.image?.resizable()
            }
            .frame(width: Constants.imageFrameWidth, height: Constants.imageFrameHeight)
            .clipShape(.rect(cornerRadius: Constants.imageCornerRadius))
            RoundedRectangle(cornerRadius: Constants.rectangleCorenerRadius)
                .frame(width: Constants.rectangleWidth, height: Constants.rectangleHeight)
                .foregroundStyle(character.status?.statusColor ?? .clear)
                .overlay {
                    Text(character.status?.rawValue ?? "")
                        .font(.headline.bold())
                        .foregroundStyle(.white)
                }
        }
        .padding()
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("Species:")
                    .font(.subheadline.bold())
                Text((character.species ?? ""))
                    .font(.subheadline)
            }
            HStack {
                Text("Gender:")
                    .font(.subheadline.bold())
                Text(character.gender ?? "")
                    .font(.subheadline)
            }
            HStack {
                Text("Episodes:")
                    .font(.subheadline.bold())
            }
            HStack {
                Text("Last known location:")
                    .font(.subheadline.bold())
                Text(character.origin?.name ?? "Earth")
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: Constants.maxFrameWidth, alignment: .leading)
    }
}

// MARK: - Nested Views


// MARK: - Nested types
private extension CharacterView {
    enum Constants {
        static let paddingTopEquel: CGFloat = -80
    }
}
private extension RickNMortyCharacter {
    enum Constants {
        static let imageFrameWidth: CGFloat = 300
        static let imageFrameHeight: CGFloat = 350
        static let imageCornerRadius: CGFloat = 15
        static let maxFrameWidth: CGFloat = 300
        static let rectangleWidth: CGFloat = 300
        static let rectangleHeight: CGFloat = 50
        static let rectangleCorenerRadius: CGFloat = 20
    }
}

// MARK: - Preview
struct CharacterView_Previews: PreviewProvider {
    static var character = RNMCharacterModel.someCharacter
    static var previews: some View {
        CharacterView(viewModel: RNMViewModel(
            api: CombineApi(),
            manager: NetworkMonitor()
        ), character: character)
    }
}
