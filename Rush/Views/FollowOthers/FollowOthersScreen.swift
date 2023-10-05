//
//  FollowOthersScreen.swift
//  Rush
//
//  Created by Aziz on 29.07.23.
//

import SwiftUI

enum FollowPlayersSection {
    case follow
    case recommended
}

struct FollowOthersScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel: FollowOthersViewModel
    
    private let rowSpacer = 30.0
    var body: some View {
        VStack {
            Spacer().frame(height: rowSpacer)
            FollowOthersView(players: $viewModel.followPlayers,
                             title: viewModel.config.followTitle,
                             section: .follow) {
                coordinator.push(.buyCoins)
            }
            Spacer().frame(height: rowSpacer)
            FollowOthersView(players: $viewModel.recommendedPlayers,
                             title: viewModel.config.recommendedTitle,
                             section: .recommended, buttonTapped: {})
            Spacer().frame(height: rowSpacer)
            ButtonView(title: "Continue") {
                coordinator.push(.buyCoins)
            }
        }
        .padding(.horizontal, 16)
    }
}


struct FollowOthersView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @Binding var players: [Player]
    let title: String
    let section: FollowPlayersSection
    let buttonTapped: () -> Void
    
    var body: some View {
        TitleViewWithSkip(title: title, isSheet: false, skipButtonIsEnabled: section == .follow) {
            buttonTapped()
        }
        ScrollView {
            VStack {
                ForEach($players) { player in
                    PlayerView(player: player)
                    Divider()
                        .frame(height: 16)
                        .foregroundColor(Colors.Opacity.line)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .scrollIndicators(.hidden)
    }
}
