//
//  JoinRequestScreen.swift
//  Rush
//
//  Created by Aziz on 26.08.23.
//

import SwiftUI

struct JoinRequestScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @State private var games = ["FIFA 2020", "NHL 2020", "MLB 2020", "Tennis 2023"]
    @State private var selectedGame = "NHL 2020"
    @State private var playerData: [StatisticsItem] = [.init(title: "Country", value: "USA"),
                                                       .init(title: "State", value: "Nevada"),
                                                       .init(title: "Stake", value: "$200"),
                                                       .init(title: "Scheduled on", value: "16 Jun 4:00PM")]
    @State var statisticsData: [StatisticsItem] = [.init(title: "Matches played", value: "64"),
                                                      .init(title: "Wins", value: "28"),
                                                      .init(title: "Earnings", value: "$726.01"),
                                                      .init(title: "Required wins", value: "3.1"),
                                                      .init(title: "Disputes", value: "2.3"),
                                                      .init(title: "Top scorer", value: "Messi"),
                                                      .init(title: "Total disputes", value: "2"),
                                                      .init(title: "Disputes won", value: "1"),
                                                      .init(title: "Reviews", value: "4.5/5")]
    
    var body: some View {
        VStack {
            header
            Spacer().frame(height: 20)
            ScrollView(showsIndicators: false) {
                Spacer().frame(height: 18)
                VStack(spacing: 30) {
                    playerProfile
                    playerInfo
                    statistics
                    matchHistory
                    buttons
                }
            }
        }
        .padding()
    }
}

extension JoinRequestScreen {
    
    var header: some View {
        HeaderView(title: "FIFA 2023 - PS5") {
            HStack(alignment: .center) {
                Spacer()
                VStack(alignment: .leading, spacing: 2) {
                    Text("Cash balance")
                        .font(AppFont.everettRegular.size(11))
                        .foregroundColor(Colors.Primary.white)
                    Text("$635")
                        .font(AppFont.everettMedium.size(20))
                        .foregroundColor(Colors.Primary.purpleB)
                }
            }
        }
    }
    
    var playerProfile: some View {
        HStack(alignment: .center) {
            Image("soni")
                .resizable()
                .frame(width: 48, height: 48)
                .cornerRadius(24)
            Spacer().frame(width: 12)
            Text("Player Soni")
                .font(AppFont.everettMedium.size(20))
                .foregroundColor(Colors.Primary.white)
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
            Spacer().frame(width: 8)
        }
        .frame(height: 85)
    }
    
    var playerInfo: some View {
        HStack {
            ForEach(Array(playerData.enumerated()), id: \.1) { index, info in
                TitleAndValueItemView(title: info.title, titleFontSize: 11, value: info.value, valueFontSize: 15)
                Spacer()
                if index != playerData.count - 1 {
                    separator
                }
                Spacer()
            }
        }
    }
    
    var separator: some View {
        VStack(spacing: 3) {
            ForEach(0..<5) { _ in
                Rectangle()
                    .fill(Colors.Opacity.line)
                    .frame(width: 1, height: 5)
            }
        }
    }
    
    var statistics: some View {
        VStack {
            HStack {
                Text("FIFA 23 Statistics")
                    .font(AppFont.everettMedium.size(20))
                    .foregroundColor(Colors.Primary.white)
                Spacer()
            }
            StatisticsGridView(statisticsData: statisticsData)
                .padding(.all, 16)
                .background(Colors.Secondary.highlightBlack)
                .cornerRadius(16)
        }
    }
    
    var buttons: some View {
        VStack(spacing: 16) {
            ButtonView(title: "Accept") {
                coordinator.pop()
            }
            ButtonView(title: "Decline", isPrimaryButton: false) {
                coordinator.pop()
            }
        }
        .padding(.all, 2)
    }
    
    var matchHistory: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 13) {
                MatchHistoryView(data: [:])
                MatchHistoryView(data: [:])
            }
        }
    }
}


struct MatchHistoryView: View {
    
    var data: [String: (String, String)]
    
    var body: some View {
        RoundedView {
            VStack(alignment: .center, spacing: 18) {
                HStack(spacing: 50) {
                    VStack {
                        Image("madrid")
                        Text("Mr. Frank")
                    }
                    Text("\(Int.random(in: 0...4))  -  \(Int.random(in: 0...4))")
                        .foregroundColor(Colors.Primary.purpleA)
                        .font(.system(size: 24, weight: .medium))
                    VStack {
                        Image("chelsea")
                        Text("Player Xino")
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Colors.Primary.black)
                )
                .foregroundColor(Colors.Primary.white)
                .font(.system(size: 11, weight: .medium))
                
                
                Text("Player Xino won the match")
                    .foregroundColor(Colors.Primary.white)
                    .font(.system(size: 17, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                
                HStack(alignment: .center) {
                    HStack {
                        Image("cal")
                        Text("11/09/20")
                    }
                    Spacer()
                    HStack {
                        Image("money")
                        Text("$200")
                    }
                    Spacer()
                    HStack {
                        Image("gameControl")
                        Text("PS5")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.gray)
                .font(.system(size: 13, weight: .medium))
                
                seperator
                HStack {
                    Text("Scorer")
                    Spacer()
                    Text("messi, messi - xavi, iniesta")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 13, weight: .medium))
                }
                
                if !data.isEmpty {
                    VStack(spacing: 12) {
                        ForEach(Array(data.keys), id: \.self) { key in
                            HStack {
                                Text(data[key]!.0)
                                    .frame(maxWidth: .infinity)
                                Text(key)
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 13, weight: .medium))
                                    .frame(maxWidth: .infinity)
                                Text(data[key]!.1)
                                    .frame(maxWidth: .infinity)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 13, weight: .medium))
                    }
                    seperator
                    
                    
                    HStack(spacing: 14) {
                        HStack(alignment: .center, spacing: 2) {
                            Image("Like")
                            Text("120")
                                .offset(y: -2)
                        }
                        
                        HStack(alignment: .center, spacing: 2) {
                            Image("Chat")
                            Text("60")
                                .offset(y: -2)
                        }
                        
                        Spacer()
                        
                        Text("View Film")
                            .foregroundColor(Colors.Primary.white)
                            .font(.system(size: 13, weight: .medium))
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(Colors.Opacity.line)
                            )
                    }
                    .foregroundColor(Color.gray)
                    .font(.system(size: 15, weight: .regular))
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    var seperator: some View {
        Rectangle()
            .fill(Colors.Opacity.line)
            .frame(height: 1)
    }
}


struct JoinRequestScreen_Previews: PreviewProvider {
    static var previews: some View {
        JoinRequestScreen()
    }
}
