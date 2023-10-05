//
//  FeedScreen.swift
//  Rush
//
//  Created by Aziz on 31.07.23.
//

import SwiftUI

struct FeedScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    let matchTabsData = ["FIFA 2023", "NFL 2023", "MBA 2023", "NBA 2023"]
    @State var selectedTab = 0
    @State var requestCount = 3
    
    var body: some View {
        VStack {
            header
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    matchTabs
                    scheduledGames
                    if requestCount > 0 {
                        incomingRequests
                    }
                    gameResults
                }
                .padding(.vertical, 30)
            }
        }
        .padding(.horizontal, 16)
    }
}

extension FeedScreen {
    
    var header: some View {
        HStack(alignment: .center) {
            Image("OnboardingImage")
                .resizable()
                .scaledToFit()
                .frame(height: 30)
            Spacer()
            Button {
                coordinator.push(.notifications)
            } label: {
                Image("notifications")
                    .resizable()
                    .padding(.all, 8)
                    .background(
                        Circle()
                            .fill(Colors.Secondary.highlightBlack)
                    )
                    .frame(width: 40, height: 40)
            }

        }
    }
    
    var matchTabs: some View {
        MatchTabsView(matchTabs: matchTabsData, selectedTab: $selectedTab)
    }
    
    var scheduledGames: some View {
        VStack(spacing: 16) {
            SectionHeaderView(title: "Scheduled Games") {
                //
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(0..<3) { _ in
                        ScheduledGameCardView()
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(width: UIScreen.main.bounds.width)
        }
    }
    
    var incomingRequests: some View {
        VStack(spacing: 16) {
            SectionHeaderView(title: "Incoming Requests") {
                //
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(repeating: 0, count: requestCount), id: \.self) { _ in
                        IncomingRequestCardView(requestCount: $requestCount)
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(width: UIScreen.main.bounds.width)
        }
    }
    
    var gameResults: some View {
        VStack(spacing: 16) {
            SectionHeaderView(title: "Game results") {
                //
            }
            gameResult
                .padding(.horizontal, 16)
        }
    }
    
    var gameResult: some View {
        VStack(spacing: 16) {
            VStack(alignment: .center, spacing: 16) {
                HStack(spacing: 8) {
                    Image("fifa")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("FIFA 2023")
                        .font(AppFont.everettMedium.size(17))
                    Spacer()
                }
                .frame(height: 24)
                Text("Player Nin9o won \nthe match")
                    .font(AppFont.everettMedium.size(15))
                    .multilineTextAlignment(.center)
                HStack {
                    VStack {
                        Image("madrid")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("Mr. Frank")
                            .font(AppFont.everettMedium.size(13))
                    }
                    Spacer()
                    Text("3  -  4")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 24, weight: .medium))
                    Spacer()
                    VStack {
                        Image("chelsea")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("Player Nin9o")
                            .font(AppFont.everettMedium.size(13))
                    }
                }
                .padding(.horizontal, 30)
            }
            .padding(.all, 16)
            .background(LinearGradient(gradient: Colors.Gradients.onboardingGradient,
                                       startPoint: .top, endPoint: .bottom))
            .cornerRadius(16)
            VStack(alignment: .leading, spacing: 16) {
                Text("Player Nin9o won the match")
                    .font(AppFont.everettMedium.size(17))
                    .foregroundColor(Colors.Primary.white)
                Text("It was a fantastic match and  both of us faces lot of nail biting moments in it. ")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(AppFont.everettRegular.size(15))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Colors.Secondary.copyText)
                HStack(spacing: 8) {
                    Image("watch")
                        .resizable()
                        .frame(width: 24)
                    Text("5 hours ago")
                    Spacer()
                    Image("money")
                        .resizable()
                        .frame(width: 24)
                    Text("$200.00")
                }
                .font(AppFont.everettRegular.size(13))
                .foregroundColor(Colors.Secondary.copyText)
                .frame(height: 24)
                Divider()
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
            .padding(.horizontal, 10)
            .frame(height: 170)
        }
        .padding([.horizontal, .top], 6)
        .padding(.bottom, 16)
        .background(Colors.Secondary.highlightBlack)
        .cornerRadius(16)
    }
}

struct IncomingRequestCardView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @Binding var requestCount: Int
    
    let data: [StatisticsItem] = [.init(title: "Scheduled on", value: "16 Jun 4:00PM"),
                                  .init(title: "Stake", value: "$200"),
                                  .init(title: "Win rate", value: "87.62%")]
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image("soni")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .cornerRadius(12)
                Spacer().frame(width: 8)
                Text("Player Soni")
                    .font(AppFont.everettMedium.size(17))
                    .foregroundColor(Colors.Primary.white)
                Spacer()
                Pill(.rectangular, text: "PS4", textColor: Colors.Primary.white)
            }
            Divider()
            HStack {
                ForEach(Array(data.enumerated()), id: \.offset) { index, item in
                    TitleAndValueItemView(title: item.title, titleFontSize: 11, value: item.value, valueFontSize: 15)
                    if index != data.count - 1 {
                        Spacer()
                    }
                }
            }
            .font(AppFont.everettRegular.size(13))
            .foregroundColor(Colors.Secondary.copyText)
            HStack(spacing: 10) {
                ButtonView(title: "Decline", height: 40, isPrimaryButton: false) {
                    if requestCount > 0 {
                        withAnimation {
                            requestCount -= 1
                        }
                    }
                }
                ButtonView(title: "Accept", height: 40) {
                    if requestCount > 0 {
                        withAnimation {
                            requestCount -= 1
                        }
                    }
                }
            }
        }
        .scaledToFill()
        .padding(.all, 16)
        .background(Colors.Secondary.highlightBlack)
        .cornerRadius(16)
        .frame(width: UIScreen.main.bounds.width * 0.7)
        .onTapGesture {
            coordinator.push(.joinRequest)
        }
    }
}

struct ScheduledGameCardView: View {
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image("fifa")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .cornerRadius(12)
                Spacer().frame(width: 8)
                Text("FIFA 2023")
                    .font(AppFont.everettMedium.size(17))
                    .foregroundColor(Colors.Primary.white)
                Spacer()
                Pill(.rectangular, text: "PS4", textColor: Colors.Primary.white)
            }
            Divider()
            HStack(spacing: 8) {
                Image("TabImage4")
                    .resizable()
                    .frame(width: 17)
                Text("Player Xino")
                Spacer()
                Image("money")
                    .resizable()
                    .frame(width: 17)
                Text("$200.00")
            }
            .frame(height: 17)
            .font(AppFont.everettRegular.size(13))
            .foregroundColor(Colors.Secondary.copyText)
            HStack(spacing: 8) {
                Image("watch")
                    .resizable()
                    .frame(width: 17)
                Text("08:40 mins left to start")
                Spacer()
            }
            .frame(height: 17)
            .font(AppFont.everettRegular.size(13))
            .foregroundColor(Colors.Secondary.copyText)
            ButtonView(title: "Play Now") {
                //
            }
        }
        .scaledToFill()
        .padding(.all, 16)
        .background(Colors.Secondary.highlightBlack)
        .cornerRadius(16)
        .frame(width: UIScreen.main.bounds.width * 0.7)
    }
}

struct SectionHeaderView: View {
    
    let title: String
    let buttonTapped: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .font(AppFont.everettMedium.size(20))
                .foregroundColor(Colors.Primary.white)
            Spacer()
            Button {
                buttonTapped()
            } label: {
                Text("View all")
                    .font(AppFont.everettMedium.size(11))
                    .foregroundColor(Colors.Primary.blue)
            }
        }
        .frame(height: 24)
        .padding(.horizontal, 16)
    }
}

struct FeedScreen_Previews: PreviewProvider {
    static var previews: some View {
        FeedScreen()
    }
}


