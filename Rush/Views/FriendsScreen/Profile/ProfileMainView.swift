//
//  ProfileMainView.swift
//  Rush
//
//  Created by Aziz on 07.08.23.
//

import SwiftUI

struct ProfileMainView: View {
    
    @State private var games = ["FIFA 2020", "NHL 2020", "MLB 2020", "Tennis 2023"]
    @State private var selectedGame = "NHL 2020"
    @State var statisticsData: [StatisticsItem] = [.init(title: "Matches played", value: "64"),
                                                      .init(title: "Wins", value: "28"),
                                                      .init(title: "Earnings", value: "$726.01"),
                                                      .init(title: "Avg. goals \nper game", value: "3.1"),
                                                      .init(title: "Avg. goals \nagainst", value: "2.3"),
                                                      .init(title: "Top scorer", value: "Messi"),
                                                      .init(title: "Total disputes", value: "2"),
                                                      .init(title: "Disputes won", value: "1"),
                                                      .init(title: "Reviews", value: "4.5/5")]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                profileInfo
                aggregateStats
                films
                matchHistory
                gameStats
                challenge
                Spacer()
            }
        }
    }
}

private extension ProfileMainView {
    
    var challenge: some View {
        ButtonView(title: "Challenge") {
            //
        }
    }
    
    var gameStats: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center) {
                Text("\(selectedGame) Statistics")
                    .foregroundColor(Colors.Primary.white)
                    .font(.system(size: 20, weight: .medium))
                Spacer()
            }
            
            StatisticsGridView(statisticsData: statisticsData)
                .padding(.all, 16)
                .background(Colors.Secondary.highlightBlack)
                .cornerRadius(16)
            
            ScrollView(.horizontal) {
                HStack {
                    matchCard
                    matchCard
                    matchCard
                    matchCard
                }
            }
        }
    }
    
    var matchCard: some View {
        MatchHistoryView(data: ["Yellow cards": ("2", "3"), "Red Cards": ("0", "0")])
    }
    
    var matchHistory: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center) {
                Text("Match History")
                    .foregroundColor(Colors.Primary.white)
                    .font(.system(size: 20, weight: .medium))
                Spacer()
                Text("View All")
                    .foregroundColor(Colors.Primary.blue)
                    .font(.system(size: 11, weight: .regular))
                
            }
            
            HStack {
                ForEach(games, id: \.self) { game in
                    Button(action: {
                        selectedGame = game
                    }) {
                        Pill(selectedGame == game ? .rectangularFilledBlue : .rectangularFilledBlack, text: game)
                    }
                    
                }
            }
            .padding(.top, 12)
            
        }
    }
    
    var films: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Films")
                .foregroundColor(Colors.Primary.white)
                .font(.system(size: 20, weight: .medium))
            
            RoundedView {
                VStack(alignment: .leading, spacing: 8) {
                    Image("film")
                        .padding(.bottom, 12)
                    
                    Text("FIFA 23")
                        .foregroundColor(Colors.Primary.purpleA)
                        .font(.system(size: 11, weight: .regular))
                    
                    
                    Text("FIFA 23 Pro Clubs, VOLTA FOOTBALL and Cross-Play Details Revealed")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 17, weight: .medium))
                    
                    HStack(spacing: 32) {
                        Text("By: ")
                        +
                        Text("STEVE NOAH")
                            .foregroundColor(Colors.Primary.blue)
                            .font(.system(size: 13, weight: .medium))
                        
                        Text("10th July, 2024")
                    }
                    .foregroundColor(Colors.Primary.white)
                    .font(.system(size: 13, weight: .regular))
                    
                    Text("EA has revealed details on FIFA 23 Pro Clubs, VOLTA FOOTBALL and cross-play today, along with...")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 14, weight: .regular))
                }
            }
        }
    }
    
    var aggregateStats: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Aggregate Stats")
                .foregroundColor(Colors.Primary.white)
                .font(.system(size: 20, weight: .medium))
            
            RoundedView {
                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            aggStatsItem(title: "Total matches played", value: "18")
                        }
                        
                        HStack(spacing: 32) {
                            aggStatsItem(title: "Total wins", value: "12")
                            aggStatsItem(title: "Total lost", value: "6")
                        }
                    }
                    .foregroundColor(Colors.Primary.white)
                    .font(.system(size: 15, weight: .medium))
                    Spacer()
                    CircularProgressView(progress: 0.4)
                        .frame(width: 84, height: 84)
                        .overlay {
                            VStack {
                                Text("Win rate")
                                    .font(AppFont.everettRegular.size(11))
                                Spacer().frame(height: 2)
                                Text("40%")
                                    .font(AppFont.everettMedium.size(20))
                                
                            }
                            .foregroundColor(Colors.Primary.white)
                        }
                }
            }
            
            RoundedView {
                HStack(spacing: 64) {
                    getStatsItem(title: "Total Disputes", value: "4")
                    getStatsItem(title: "Disputes won", value: "3")
                    Spacer()
                }
                .foregroundColor(Colors.Primary.white)
                .font(.system(size: 15, weight: .medium))
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var profileInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image("wong")
                .padding(.top, 8)
            Text("Sh Xing Wong")
                .foregroundColor(Colors.Primary.white)
                .font(.system(size: 20, weight: .medium))
                .padding(.top, 8)
            Text(Image("pin")) + Text("  Osaka, Japan")
            
            Text("This is sample bio where you can talk about yourself and your achievements.")
                .padding(.top, 12)
            
            HStack() {
                VStack {
                    Text("$535.44")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 15, weight: .medium))
                    Text("Earnings")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 11, weight: .medium))
                }
                Spacer()
                VStack {
                    Text("32")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 15, weight: .medium))
                    Text("Following")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 11, weight: .medium))
                }
                Spacer()
                VStack {
                    Text("5k")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 15, weight: .medium))
                    Text("Followers")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 11, weight: .medium))
                }
                Spacer()
                Rectangle()
                    .fill(Colors.Secondary.highlightBlack)
                    .frame(width: 1, height: 30)
                    .layoutPriority(-1)
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(Image("shield"))
                    +
                    Text("  Rank 82")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 15, weight: .medium))
                    
                    Text("Amateur")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 11, weight: .medium))
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 18)
            
            
            HStack {
                ForEach(games, id: \.self) { game in
                    Pill(text: game)
                }
            }
            .padding(.top, 12)
            
            
        }
        .foregroundColor(Colors.Primary.white)
        .font(.system(size: 13, weight: .regular))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    

    func aggStatsItem(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .foregroundColor(Color.gray)
                .font(.system(size: 13, weight: .regular))
            Text(value)
        }
        .foregroundColor(Colors.Primary.white)
        .font(.system(size: 18, weight: .medium))
    }
    
    func getStatsItem(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .foregroundColor(Color.gray)
                .font(.system(size: 13, weight: .regular))
            Text(value)
        }
        .foregroundColor(Colors.Primary.white)
        .font(.system(size: 15, weight: .medium))
    }
}
