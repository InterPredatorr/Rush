//
//  GeneralView.swift
//  Rush
//
//  Created by Aziz on 31.07.23.
//

import SwiftUI

struct GeneralScreen: View {
    
    @State private var selection = 0
    let titles = ["Feed",
                  "Friends",
                  "Leaderboard",
                  "Match Room",
                  "Profile"]
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Colors.Secondary.highlightBlack)
    }
    
    var body: some View {
        TabView(selection: $selection) {
            FeedScreen()
                .tabItem { Label(titles[0], image: ImageResources.tabImage(at: 0)) }.tag(0)
            FriendsScreen()
                .tabItem { Label(titles[1], image: ImageResources.tabImage(at: 1)) }.tag(1)
            LeaderboardScreen()
                .tabItem { Label(titles[2], image: ImageResources.tabImage(at: 2)) }.tag(2)
            MatchRoomScreen()
                .tabItem { Label(titles[3], image: ImageResources.tabImage(at: 3)) }.tag(3)
            ProfileScreen(isTabView: true)
                .tabItem { Label(titles[4], image: ImageResources.tabImage(at: 4)) }.tag(4)
        }
    }
}
