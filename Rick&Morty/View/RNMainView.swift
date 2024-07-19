//
//  RNMainView.swift
//  Rick&Morty
//
//  Created by Artem Rodionov on 17.07.2024.
//

import SwiftUI

struct RNMainView: View {
// MARK: - Property Wrappers
    @ObservedObject var viewModel: RNMViewModel
    @State var cellFrames: CellFrames = .init()
// MARK: - Property
    private static let geometry = NamedCoordinateSpace.named("geometry")
// MARK: - Main Body View
    var body: some View {
        if viewModel.isConnected {  // Check Connection
            VStack {
                NavigationStack {
                    HStack(alignment: .top) {
                        Text("Rick & Morty Characters")
                            .font(.title.bold())
                    }
                    .frame(alignment: .top)
                    VStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVStack {
                                scrollViewContentBody
                            }
                            .coordinateSpace(Self.geometry)
                        }
                        .contentMargins(.vertical, Constants.scrollVerticalMargin)
                        .scrollTargetBehavior(CellFramesScrollTargetBehavior(cellFrames: cellFrames))
                        .onPreferenceChange(CellFrames.self) { cellFrames = $0 }
                        }
                }
            }
        } else { // Connection Error WiFi-disconnected
            errorViewContent
        }
    }
// MARK: - ViewBuilder Methods/properties
    @ViewBuilder
    private var scrollViewContentBody: some View {
        ForEach(viewModel.loadedCharacters, id: \.id) { character in
            NavigationLink(destination: CharacterView(viewModel: RNMViewModel(api: CombineApi(), 
                            manager: NetworkMonitor()),
                            character: character)) {
                RNMCellCharacterView(character: character)
                    .background {
                        GeometryReader { proxy in
                            Color.clear
                                .preference(
                                    key: CellFrames.self,
                                    value: CellFrames(
                                        frames: [character: proxy.frame(in: Self.geometry)]
                                    )
                                )
                        }
                    }
            }
        }
        .padding(.bottom, Constants.cellPadding)
    }
// MARK: - Error View
    private var errorViewContent: some View {
        VStack() {
            Image("NetworkError")
                .frame(width: Constants.imageErrorFrameWidth,
                       height: Constants.imageErrorFrameHeight)
            VStack(alignment: .center, spacing: 5) {
                Text("Network Error")
                    .font(.title.bold())
                Text(("There was an error connectig."))
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                Text(("Please check your internet"))
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
    }
}

// MARK: - Nested types
private extension RNMainView {
    enum Constants {
        static let scrollVerticalMargin: CGFloat = 30
        static let scrollBottomPadding: CGFloat = -30
        static let errorTopPadding:CGFloat = -300
        static let cellPadding: CGFloat = -30
        static let imageErrorFrameWidth: CGFloat = 200
        static let imageErrorFrameHeight: CGFloat = 200
    }
}

// MARK: - Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        RNMainView(
            viewModel: RNMViewModel(
                api: CombineApi(),
                manager: NetworkMonitor()
            )
        )
    }
}
