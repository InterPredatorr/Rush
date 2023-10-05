//
//  MatchRequestScreen.swift
//  Rush
//
//  Created by Aziz on 26.08.23.
//

import SwiftUI

enum MatchRequestPage {
    case requestPreview
    case acceptedRequest
}

struct MatchRequestScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @State private var currentPage: MatchRequestPage = .requestPreview
    let gameMode: CreateMatchDetailView.SelectedGameMode
    let gameData: [StatisticsItem] = [.init(title: "Version", value: "2023"),
                                      .init(title: "Platform", value: "PS5"),
                                      .init(title: "Stake", value: "$70")]
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
        VStack(spacing: 30) {
            header
            ScrollViewReader { reader in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        Color.clear.frame(height: 0).id("top")
                        switch currentPage {
                        case .requestPreview:
                            playerTop
                            gameInfo
                            CurrentMatchPlayerProgressView()
                        case .acceptedRequest:
                            AcceptedRequestScreen()
                                .onAppear {
                                    withAnimation {
                                        reader.scrollTo("top")
                                    }
                                }
                        }
                        playerProgress
                        Spacer()
                    }
                }
                
            }
            ButtonView(title: "Withdraw requset") {
                switch currentPage {
                case .requestPreview:
                    withAnimation {
                        currentPage = .acceptedRequest
                    }
                case .acceptedRequest:
                    coordinator.popToRoot()
                }
            }
        }
        .padding()
        
    }
}

extension MatchRequestScreen {
    
    var header: some View {
        HeaderView(title: currentPage == .requestPreview ? ("\(gameMode == .privateGame ? "Private" : "Public") Match request") : "Created request") {
            switch currentPage {
            case .requestPreview:
                coordinator.pop()
            case .acceptedRequest:
                withAnimation {
                    currentPage = .requestPreview
                }
            }
        }
    }
    
    var playerTop: some View {
        VStack(alignment: .center, spacing: 16) {
            Image("wong")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(50)
                .overlay {
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(lineWidth: 2)
                        .fill(Colors.Opacity.line)
                }
            Text("Waiting for opponent")
                .font(AppFont.everettMedium.size(20))
            Text("time remaining 7:23:40")
                .font(AppFont.everettMedium.size(28))
        }
    }
    
    var gameInfo: some View {
        MatchRequestGameInfoView(gameData: gameData)
            .padding(.all, 16)
            .background(Colors.Secondary.highlightBlack)
            .cornerRadius(16)
    }
    
    var playerProgress: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("FIFA 23 Statistics")
                    .font(AppFont.everettMedium.size(20))
                    .foregroundColor(Colors.Primary.white)
                StatisticsGridView(statisticsData: statisticsData)
                    .padding(.all, 16)
                    .background(Colors.Secondary.highlightBlack)
                    .cornerRadius(16)
            }
        }
    }
}

struct MatchRequestGameInfoView: View {
    
    let gameData: [StatisticsItem]
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                Image("fifa")
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("FIFA")
                    .font(AppFont.everettMedium.size(20))
                Spacer()
                ForEach(gameData, id: \.self) { item in
                    TitleAndValueItemView(title: item.title, titleFontSize: 11, value: item.value)
                }
            }
            Divider()
            HStack {
                MatchCustomButtonView(title: "Legend", dotColor: Colors.Primary.blue, backgroundColor: Colors.Opacity.b)
                Spacer()
                MatchCustomButtonView(title: "10 min quarters", dotColor: Colors.Primary.purpleB, backgroundColor: Colors.Opacity.a)
            }
            
        }
    }
}

struct AcceptedRequestScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    let gameData: [StatisticsItem] = [.init(title: "Total earnings", value: "$6510"),
                                      .init(title: "Disputs", value: "0"),
                                      .init(title: "Win rate", value: "87.62%")]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {
                Text("Accepted request")
                    .font(AppFont.everettMedium.size(24))
                playerCard
                gameInfo
            }
        }
    }
}

extension AcceptedRequestScreen {
    
    var playerCard: some View {
        VStack(spacing: 16) {
            HStack {
                Image("wong")
                    .resizable()
                    .frame(width: 48)
                VStack(spacing: 6) {
                    Text("Wong Player")
                        .font(AppFont.everettMedium.size(17))
                        .foregroundColor(Colors.Primary.white)
                    Text("5.9k followers")
                        .font(AppFont.everettRegular.size(13))
                        .foregroundColor(Colors.Secondary.copyText)
                }
                Spacer()
                Text("Nevada, USA")
                    .font(AppFont.everettRegular.size(11))
                    .foregroundColor(Colors.Secondary.copyText)
            }
            .frame(height: 48)
            Divider()
            HStack {
                ForEach(gameData, id: \.self) { item in
                    TitleAndValueItemView(title: item.title, value: item.value)
                    if item.title != gameData.last?.title {
                        Spacer()
                    }
                }
            }
            Divider()
            HStack(spacing: 13) {
                ButtonView(title: "Chat", height: 40, textColor: Colors.Secondary.copyText, isPrimaryButton: false) {
                    coordinator.push(.chat)
                }
                ButtonView(title: "I'm ready", height: 40) {
                    coordinator.pop()
                }
            }
        }
        .padding(.all, 16)
        .background(Colors.Secondary.highlightBlack)
        .cornerRadius(16)
    }
    
    var gameInfo: some View {
        VStack(spacing: 16) {
            HStack {
                Text("League level")
                    .font(AppFont.everettRegular.size(13))
                    .foregroundColor(Colors.Secondary.copyText)
                Spacer().frame(width: 8)
                Text("Professional")
                    .font(AppFont.everettMedium.size(15))
            }
            Divider()
            HStack {
                Text("Scheduled start")
                    .font(AppFont.everettMedium.size(15))
                    .foregroundColor(Colors.Primary.white)
                Spacer()
                Text("June 16 4:00PM EST")
                    .font(AppFont.everettRegular.size(13))
                    .foregroundColor(Colors.Secondary.copyText)
            }
            Divider()
            MatchRequestGameInfoView(gameData: gameData)
        }
        .padding(.all, 16)
        .background(Colors.Secondary.highlightBlack)
        .cornerRadius(16)
    }
}

struct MatchRequestScreen_Previews: PreviewProvider {
    static var previews: some View {
        MatchRequestScreen(gameMode: .privateGame)
    }
}
