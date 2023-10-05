//
//  MatchRoomScreen.swift
//  Rush
//
//  Created by Aziz on 31.07.23.
//

import SwiftUI

struct MatchRoomScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    let matchTabs = ["FIFA 2023", "NFL 2023", "MBA 2023", "NBA 2023"]
    @State var filters = ["2023", "USA", "10K-50K followers", "PS5", "20-50% Winrate", "$1000+ earnings"]
    
    @State var selectedTab = 0
    @State var searchText = ""
    
    var body: some View {
        VStack {
            header
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    tabs
                    searchField
                    if !filters.isEmpty {
                        filterLabels
                        Divider().foregroundColor(Colors.Opacity.line)
                    }
                    players
                }
                .padding(.vertical, 30)
                .padding(.horizontal, 2)
            }
        }
        .padding(.horizontal, 16)
    }
    
}

struct RequestToPlayScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    let tokenBought: Bool
    @State var buttonSecondaryTitle = "Send Request"
    @State var requestSent = false
    
    var body: some View {
        VStack(spacing: 16) {
            SheetsDragIndicator()
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Request to play")
                        .font(AppFont.everettMedium.size(20))
                        .foregroundColor(Colors.Primary.white)
                    Text("You'll be charged one token if they accept your request to play.")
                        .lineLimit(2)
                        .font(AppFont.everettRegular.size(13))
                        .foregroundColor(Colors.Secondary.copyText)
                }
                Spacer()
                Image("FeedTopBadge")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .cornerRadius(12)
                Spacer().frame(width: 6)
                Text("100 tokens")
                    .frame(height: 24)
                    .font(AppFont.everettMedium.size(15))
                    .foregroundColor(Colors.Primary.white)
            }
            Divider()
            PlayerCardView()
            Divider()
            PlayerMatchSettingsView()
            Spacer()
            ButtonView(title: tokenBought ? buttonSecondaryTitle : "Buy more tokens") {
                if tokenBought {
                    if requestSent {
                        coordinator.dismiss()
                        coordinator.push(.currentMatch)
                        return
                    }
                    requestSent.toggle()
                    buttonSecondaryTitle = "Request Sent!"
                } else {
                    coordinator.dismiss()
                    coordinator.present(fullScreenCover: .buyCoins)
                }
            }
        }
        .padding(.horizontal, 16)
        .background(Colors.Secondary.highlightBlack)
    }
}

struct PlayerMatchSettingsView: View {
    
    var haveDivider = false
     
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("Scheduled")
                        .font(AppFont.everettMedium.size(11))
                        .foregroundColor(Colors.Secondary.copyText)
                    Spacer()
                    Text("Anytime")
                        .font(AppFont.everettMedium.size(15))
                        .foregroundColor(Colors.Primary.white)
                }
                Spacer()
                GeometryReader { reader in
                    Text("Match Settings")
                        .position(x: reader.frame(in: .local).midX - 15,
                                  y: reader.size.height / 2)
                        .font(AppFont.everettMedium.size(17))
                        .foregroundColor(Colors.Primary.white)
                        .lineLimit(2)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Stake")
                        .font(AppFont.everettMedium.size(11))
                        .foregroundColor(Colors.Secondary.copyText)
                    Spacer()
                    Text("$70")
                        .font(AppFont.everettMedium.size(15))
                        .foregroundColor(Colors.Primary.white)
                }
            }
            .frame(height: 40)
            if haveDivider {
                Divider().foregroundColor(Colors.Opacity.line)
            }
            HStack(spacing: 13) {
                MatchCustomButtonView(title: "Legend", dotColor: Colors.Primary.blue, backgroundColor: Colors.Opacity.b)
                MatchCustomButtonView(title: "10 min quarters", dotColor: Colors.Primary.purpleB, backgroundColor: Colors.Opacity.a)
            }
        }
    }
}

struct MatchCustomButtonView: View {
    
    let title: String
    let dotColor: Color
    let backgroundColor: Color
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 7, height: 7)
                .foregroundColor(dotColor)
            Spacer().frame(width: 4)
            Text(title)
                .font(AppFont.everettMedium.size(13))
                .foregroundColor(Colors.Primary.white)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(backgroundColor)
        }
    }
}

struct PlayerCardView: View {
    
    var body: some View {
        HStack(alignment: .center) {
            Image("FIFA23")
                .resizable()
                .frame(width: 48, height: 48)
                .cornerRadius(24)
            Spacer().frame(width: 12)
            VStack(alignment: .leading) {
                Text("Nevergaveup782x")
                    .font(AppFont.everettMedium.size(17))
                    .foregroundColor(Colors.Primary.white)
                Spacer()
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
    }
}

private extension MatchRoomScreen {
    var header: some View {
        HStack(alignment: .center) {
            Text("Match Room")
                .font(AppFont.everettMedium.size(28))
                .foregroundColor(Colors.Primary.white)
            Spacer()
            Button {
                coordinator.push(.createMatch)
            } label: {
                Circle()
                    .stroke(lineWidth: 1)
                    .fill(Colors.Opacity.line)
                    .frame(width: 40, height: 40)
                    .background(Colors.Secondary.highlightBlack)
                    .cornerRadius(20)
                    .overlay {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(Colors.Primary.white)
                    }
            }
        }
    }
    
    var tabs: some View {
        MatchTabsView(matchTabs: matchTabs, selectedTab: $selectedTab)
    }
    
    var searchField: some View {
        SearchField(searchText: $searchText)
            .overlay {
                HStack {
                    Spacer()
                    Button {
                        coordinator.present(.filterScreen, size: .fraction(0.8))
                    } label: {
                        Image("Filter")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .background {
                                Circle()
                                    .stroke(lineWidth: 1)
                                    .fill(Colors.Opacity.line)
                                    .frame(width: 32, height: 32)
                                    .background(Colors.Secondary.highlightBlack)
                                    .cornerRadius(16)
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 1.5)
                                    .fill(Colors.Secondary.highlightBlack)
                                Circle()
                                    .fill(Colors.Primary.blue)
                                    .frame(width: 10, height: 10)
                                    .position(x: 22, y: 0)
                                    .overlay {
                                        Circle()
                                        .stroke(lineWidth: 1.5)
                                        .fill(Colors.Secondary.highlightBlack)
                                    }
                            }
                    }
                    Spacer().frame(width: 16)
                }
            }
    }
    
    var filterLabels: some View {
        
        GeometryReader { reader in
            FilterItemsView(filters: $filters, geometry: reader)
        }
        .frame(height: CGFloat((filters.count / 3 + 2) * 35))
    }
    
    var players: some View {
        VStack(spacing: 16) {
            ForEach(0..<3) { _ in
                MatchPlayerCardView()
            }
        }
    }
}

struct MatchTabItemView: View {
    
    let imageName: String
    let title: String
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            Spacer().frame(width: 6)
            Text(title)
                .font(AppFont.everettMedium.size(17))
                .foregroundColor(Colors.Primary.white)
        }
        .frame(height: 28)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background {
            (isSelected ? Colors.Primary.purpleA : Colors.Secondary.highlightBlack)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: isSelected ? 0 : 1)
                        .fill(Colors.Opacity.line)
                }
        }
    }
}

struct FilterItemsView: View {
    @Binding var filters: [String]
    
    let geometry: GeometryProxy

    var body: some View {
        if !filters.isEmpty {
            self.generateContent(in: geometry)
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.filters, id: \.self) { filter in
                self.item(for: filter)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        width = filter == self.filters.first! ? 0 : width - d.width
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        height = filter == self.filters.first! ? 0 : height
                        return result
                    })
            }
        }
    }

    func item(for text: String) -> some View {
        HStack(spacing: 4) {
            Text(text)
                .font(AppFont.everettMedium.size(13))
                .background(Colors.Secondary.highlightBlack)
                .foregroundColor(Colors.Primary.white)
                .cornerRadius(5)
            Button {
                withAnimation {
                    filters.removeAll(where: { $0 == text })
                }
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 14, height: 14)
                    .foregroundColor(Colors.Opacity.bg)
            }

        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background {
            Colors.Secondary.highlightBlack
                .overlay {
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(lineWidth: 2)
                        .fill(Colors.Opacity.line)
                }
            
        }
        .cornerRadius(50)
    }
}

struct StatisticsItem: Hashable {
    let title: String
    let value: String
}

struct MatchPlayerCardView: View {
    
    @EnvironmentObject private var coordinator: Coordinator

    
    let statisticsData: [StatisticsItem] = [.init(title: "Matches played", value: "78"),
                              .init(title: "Wins", value: "61"),
                              .init(title: "Earnings", value: "01"),
                              .init(title: "Required wins", value: "4"),
                              .init(title: "Disputes", value: "2"),
                              .init(title: "Top scorer", value: "Ronaldo"),
                              .init(title: "Total disputes", value: "2"),
                              .init(title: "Disputes won", value: "1"),
                              .init(title: "Reviews", value: "4.5/5")]
    
    var body: some View {
        VStack(spacing: 16) {
            cardHeader
            Divider().foregroundColor(Colors.Opacity.line)
            PlayerMatchSettingsView(haveDivider: true)
            statistics
            ButtonView(title: "Request to play", height: 40) {
                coordinator.present(.requestToPlay(false), size: .medium)
            }
        }
        .padding(.all, 16)
        .background {
            Colors.Secondary.highlightBlack
                .cornerRadius(16)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(lineWidth: 1)
                        .fill(Colors.Opacity.line)
                }
        }
    }
    
    var cardHeader: some View {
        PlayerCardView()
    }
    
    var statistics: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                Text("League Level")
                    .font(AppFont.everettRegular.size(13))
                    .foregroundColor(Colors.Secondary.copyText)
                Spacer().frame(width: 7)
                Text("Professional")
                    .font(AppFont.everettMedium.size(15))
                    .foregroundColor(Colors.Primary.white)
                Spacer()
            }
            StatisticsGridView(statisticsData: statisticsData)

        }
        .padding(.all, 16)
        .background(Colors.Primary.black)
        .cornerRadius(16)
    }
}


struct TitleAndValueItemView: View {
    
    let title: String
    var titleFontSize: CGFloat? = nil
    let value: String
    var valueFontSize: CGFloat? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .font(AppFont.everettRegular.size(titleFontSize ?? 13))
                .foregroundColor(Colors.Secondary.copyText)
            Text(value)
                .font(AppFont.everettMedium.size(valueFontSize ?? 15))
                .foregroundColor(Colors.Primary.white)
        }
    }
}


struct MatchTabsView: View {
    
    let matchTabs: [String]
    @Binding var selectedTab: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Array(matchTabs.enumerated()), id: \.offset) { (index, element) in
                    MatchTabItemView(imageName: ImageResources.fifa, title: element, isSelected: index == selectedTab)
                        .onTapGesture { withAnimation { selectedTab = index } }
                }
            }
            .padding(.vertical, 2)
            .padding(.horizontal, 16)
        }
    }
}
