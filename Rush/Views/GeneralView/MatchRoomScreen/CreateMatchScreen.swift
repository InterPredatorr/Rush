//
//  CreateMatchScreen.swift
//  Rush
//
//  Created by Aziz on 26.08.23.
//

import SwiftUI

enum CreateMatchPage {
    case selectGame
    case enterDetail
}

struct CreateMatchScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @State var currentPage: CreateMatchPage = .selectGame
    @State var selectedMode: CreateMatchDetailView.SelectedGameMode = .publicGame
    
    var body: some View {
        VStack(spacing: 30) {
            header
            switch currentPage {
            case .selectGame:
                CreateMatchSelectGameView()
            case .enterDetail:
                CreateMatchDetailView(selectedMode: $selectedMode)
            }
            ButtonView(title: currentPage == .selectGame ? "Continue" : "Create request with 2 tokens") {
                switch currentPage {
                case .selectGame:
                    withAnimation {
                        currentPage = .enterDetail
                    }
                case .enterDetail:
                    coordinator.push(.matchRequest(selectedMode))
                }
            }
        }
        .padding()
    }
}

extension CreateMatchScreen {
    
    var header: some View {
        HeaderView(title: "Create match") {
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
        } backButtonTapped: {
            switch currentPage {
            case .selectGame:
                coordinator.pop()
            case .enterDetail:
                withAnimation {
                    currentPage = .selectGame
                }
            }
        }
    }
}

struct CreateMatchSelectGameView: View {
    
    @State var games = SettingsManager.shared.journey.games.items
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Select a game to play")
                .font(AppFont.everettMedium.size(24))
                .foregroundColor(Colors.Primary.white)
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [.init(.flexible()), .init(.flexible()), .init(.flexible())]) {
                    ForEach(games, id: \.self) { item in
                        JourneyGameItemView(item: item)
                            .onTapGesture {
                                withAnimation {
                                    updateSelectedGame(with: item.gameName)
                                }
                            }
                    }
                    Spacer()
                }
                .padding(.all, 2)
            }
        }
        .onAppear {
            games[0].isSelected = true
        }
    }
    
    func updateSelectedGame(with name: String) {
        games = games.map { game in
            var tmp = game
            tmp.isSelected = tmp.gameName == name
            return tmp
        }
    }
}

struct CreateMatchDetailView: View {
    
    enum SelectedGameMode {
        case publicGame
        case privateGame
    }
    
    @Binding var selectedMode: SelectedGameMode
    @State private var stakeText = ""
    @State private var idText = ""
    @State private var dateText: Date = .now
    @State private var timeText: Date = .now
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Enter the details below")
                    .font(AppFont.everettMedium.size(24))
                Spacer().frame(height: 6)
                Text("Enter stake")
                TextFieldView(config: .init(title: "", placeholderText: ""), text: $stakeText, isSecure: false)
                Text("Select mode")
                    .font(AppFont.everettMedium.size(17))
                HStack(spacing: 13) {
                    ButtonView(title: "Public", height: 40, isPrimaryButton: selectedMode == .publicGame) {
                        withAnimation {
                            selectedMode = .publicGame
                        }
                    }
                    ButtonView(title: "Private", height: 40, isPrimaryButton: selectedMode == .privateGame) {
                        withAnimation {
                            selectedMode = .privateGame
                        }
                    }
                }
                Spacer().frame(height: 6)
                if selectedMode == .privateGame {
                    Text("Enter friend ID")
                        .font(AppFont.everettMedium.size(17))
                    TextFieldView(config: .init(title: "", placeholderText: ""), text: $idText, isSecure: false)
                    HStack {
                        Spacer()
                        Text("Choose from list")
                            .font(AppFont.everettRegular.size(13))
                    }
                }
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Colors.Primary.purpleB)
                    Text("Schedule Match")
                        .font(AppFont.everettMedium.size(17))
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 16) {
                    Text("Schedule date")
                        .font(AppFont.everettMedium.size(17))
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .fill(Colors.Opacity.line)
                        .frame(height: 48)
                        .background(Colors.Secondary.highlightBlack.cornerRadius(10))
                        .overlay {
                            HStack {
                                Spacer().frame(width: 50)
                                Text(dateText.formatted(date: .numeric, time: .omitted))
                                    .font(AppFont.everettMedium.size(15))
                                Spacer()
                                DatePicker("", selection: $dateText, in: Date.now..., displayedComponents: .date)
                                    .tint(Color.blue)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .allowsHitTesting(true)
                                    .opacity(0.0101)
                                    .background {
                                        Colors.Primary.black
                                        HStack {
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .resizable()
                                                .frame(width: 15, height: 10)
                                            Spacer().frame(width: 16)
                                        }
                                        .frame(maxHeight: .infinity)
                                        .background(Colors.Secondary.highlightBlack)
                                    }
                            }
                        }
                    Text("Schedule time")
                        .font(AppFont.everettMedium.size(17))
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .fill(Colors.Opacity.line)
                        .frame(height: 48)
                        .background(Colors.Secondary.highlightBlack.cornerRadius(10))
                        .overlay {
                            HStack {
                                Spacer().frame(width: 50)
                                Text(timeText.formatted(date: .omitted, time: .complete))
                                    .font(AppFont.everettMedium.size(15))
                                Spacer()
                                DatePicker("", selection: $timeText, in: Date.now..., displayedComponents: .hourAndMinute)
                                    .preferredColorScheme(.dark)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .allowsHitTesting(true)
                                    .opacity(0.0101)
                                    .background {
                                        Colors.Primary.black
                                        HStack {
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .resizable()
                                                .frame(width: 15, height: 10)
                                            Spacer().frame(width: 16)
                                        }
                                        .frame(maxHeight: .infinity)
                                        .background(Colors.Secondary.highlightBlack)
                                    }
                                
                            }
                        }
                    Spacer()
                }
            }
        }
    }
}

struct CreateMatchScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateMatchScreen()
    }
}
