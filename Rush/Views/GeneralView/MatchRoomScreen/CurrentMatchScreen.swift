//
//  CurrentMatchScreen.swift
//  Rush
//
//  Created by Aziz on 11.08.23.
//

import SwiftUI

struct CurrentMatchScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @State var statisticsData: [StatisticsItem] = [.init(title: "Matches played", value: "64"),
                                                      .init(title: "Wins", value: "28"),
                                                      .init(title: "Earnings", value: "$726.01"),
                                                      .init(title: "Required wins", value: "3.1"),
                                                      .init(title: "Disputes", value: "2.3"),
                                                      .init(title: "Top scorer", value: "Messi"),
                                                      .init(title: "Total disputes", value: "2"),
                                                      .init(title: "Disputes won", value: "1"),
                                                      .init(title: "Reviews", value: "4.5/5")]
    let firstTitle = "I’m ready to play"
    @State var buttonTitle = ""
    @State var showProgressView = false
    @State var isMatchActive = false
    
    var body: some View {
        VStack(spacing: 30) {
            header
            ScrollView(showsIndicators: false) {
                VStack {
                    if isMatchActive {
                        ActiveMatchView()
                    }
                    topCard
                    Spacer().frame(height: 30)
                    CurrentMatchPlayerProgressView()
                    statistics
                    
                }
                .padding(.vertical, 16)
                .onAppear {
                    buttonTitle = firstTitle
                }
            }
            ButtonView(title: buttonTitle, isProgressViewEnabled: showProgressView) {
                coordinator.present(.startMatch, size: .fraction(0.35)) {
                
                    buttonTitle = "Waiting for opponent"
                    showProgressView = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // <----- will be removed
                        buttonTitle = "Detecting Twitch stream"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isMatchActive.toggle()
                                buttonTitle = "End Game"
                                showProgressView = false
                            }
                        }
                    }
                }
                if isMatchActive { coordinator.present(.endMatch, size: .fraction(GlobalVariables.endMatchSheetFraction)) }
            }
        }
        .padding(.horizontal, 16)
    }
}


private extension CurrentMatchScreen {
    var header: some View {
        HeaderView(title: isMatchActive ? "Xino Room" : " ", titleOffset: -50) {
            HStack {
                ButtonView(title: "Done", height: 33, font:  AppFont.everettMedium.size(13), cornerRadius: 8, backgroundColor: Colors.Primary.purpleA) {
                    coordinator.pop()
                }
                .frame(minWidth: 65)
                Circle()
                    .fill(Colors.Secondary.highlightBlack)
                    .frame(width: 40, height: 40)
                    .overlay(Image("threeDots"))
                    .onTapGesture {
                        
                    }
            }
        }
    }
    
    var topCard: some View {
        VStack(spacing: 16) {
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
            HStack(spacing: 10) {
                Image("fifa")
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("FIFA")
                    .font(AppFont.everettMedium.size(20))
                    .foregroundColor(Colors.Primary.white)
                    .lineLimit(1)
                Spacer()
                TitleAndValueItemView(title: "Version", titleFontSize: 11, value: "2023", valueFontSize: 15)
                TitleAndValueItemView(title: "Platform", titleFontSize: 11, value: "PS5", valueFontSize: 15)
                TitleAndValueItemView(title: "Stake", titleFontSize: 11, value: "$70", valueFontSize: 15)
            }
            Divider()
            HStack(spacing: 13) {
                MatchCustomButtonView(title: "Legend", dotColor: Colors.Primary.blue, backgroundColor: Colors.Opacity.b)
                MatchCustomButtonView(title: "10 min quarters", dotColor: Colors.Primary.purpleB, backgroundColor: Colors.Opacity.a)
            }
            
        }
        .padding(.all, 16)
        .background(Colors.Secondary.highlightBlack)
        .cornerRadius(16)
    }
    
    var statistics: some View {
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


struct CurrentMatchPlayerProgressView: View {
    
    var body: some View {
        HStack {
            Image("wong")
                .resizable()
                .frame(width: 48, height: 48)
                .cornerRadius(24)
            Spacer().frame(width: 12)
            VStack(alignment: .leading, spacing: 4) {
                Text("Xing Wong")
                    .font(AppFont.everettMedium.size(20))
                    .foregroundColor(Colors.Primary.white)
                Text("Nevada, USA")
                    .font(AppFont.everettRegular.size(13))
                    .foregroundColor(Colors.Secondary.copyText)
                Text("5.9k followers")
                    .font(AppFont.everettRegular.size(13))
                    .foregroundColor(Colors.Secondary.copyText)
            }
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
            Spacer().frame(width: 10)
        }
        .frame(maxWidth: .infinity)
    }
}

struct StatisticsGridView: View {
    
    let statisticsData: [StatisticsItem]
    
    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 20) {
            ForEach(0..<(statisticsData.count / 3), id: \.self) { row in
                GridRow(alignment: .firstTextBaseline) {
                    ForEach((row * 3)..<(row * 3 + 3), id: \.self) { index in
                        TitleAndValueItemView(title: statisticsData[index].title, value: statisticsData[index].value)
                    }
                }
                if row != statisticsData.count / 3 - 1 {
                    Divider()
                }
            }
        }
    }
}


struct StartMatchSheetView: View {
    
    let buttonTitle = "Start Match"
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack {
            SheetsDragIndicator()
            Text("Invite your opponent")
                .font(AppFont.everettMedium.size(20))
                .foregroundColor(Colors.Primary.white)
                .frame(alignment: .leading)
            Divider()
            StartMatchRowItemView(title: "In your console, add your opponent as a friend.", imageName: "IconPS5")
            Spacer().frame(height: 20)
            StartMatchRowItemView(title: "Chat with your opponent, confirm they’re ready, and select Start Match.", imageName: "Chat")
            
            ButtonView(title: buttonTitle) {
                coordinator.dismiss()
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(Colors.Secondary.highlightBlack)
    }
}

struct StartMatchRowItemView: View {
    
    let title: String
    let imageName: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(imageName)
                .resizable()
                .foregroundColor(Colors.Primary.purpleB)
                .frame(width: 24, height: 24)
                .background {
                    Circle()
                        .stroke(lineWidth: 1)
                        .fill(Colors.Opacity.line)
                        .foregroundColor(Colors.Primary.black)
                        .frame(width: 40, height: 40)
                }
            Text(title)
                .font(AppFont.everettRegular.size(15))
                .foregroundColor(Colors.Primary.white)
            Spacer()
        }
        .frame(height: 44)
    }
}


struct ActiveMatchView: View {
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var time: TimeInterval = 0
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center) {
                VStack {
                    Image("wong")
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("Xing wong")
                        .font(AppFont.everettMedium.size(13))
                        .foregroundColor(Colors.Primary.white)
                }
                Spacer()
                HStack {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.green)
                    Spacer().frame(width: 4)
                    Text(timeString(time: time))
                        .font(AppFont.everettMedium.size(15))
                        .foregroundColor(Colors.Primary.white)
                        .onReceive(timer) { _ in
                            time += 1
                        }
                }
                Spacer()
                VStack {
                    Image("curran")
                        .frame(width: 40, height: 40)
                    Text("Nevergaveup")
                        .font(AppFont.everettMedium.size(13))
                        .foregroundColor(Colors.Primary.white)
                }
            }
            Divider()
            HStack {
                Text("For $70")
                    .font(AppFont.everettMedium.size(17))
                    .foregroundColor(Colors.Primary.white)
                Spacer()
                Button {
                    //
                } label: {
                    Image("share")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
        }
        .padding(.all, 16)
        .background(Colors.Secondary.highlightBlack)
        .cornerRadius(14)
        .onDisappear {
            timer.upstream.connect().cancel()
        }
    }
    
    func timeString(time: TimeInterval) -> String {
            return String(format: "%02i:%02i:%02i",
                          Int(time) / 3600,
                          Int(time) / 60 % 60,
                          Int(time) % 60)
        }
}

struct EndMatchSheetView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        MatchOptionView(title: "Are you sure to end game?", option1: "No", option2: "Yes") { isPositive in
            coordinator.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if isPositive { coordinator.present(.scoreInput, size: .fraction(0.5)) }
            }
        }
        .padding(.horizontal, 16)
        .background(Colors.Secondary.highlightBlack)
    }
}

struct ScoreInputSheetView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @State var score1 = ""
    @State var score2 = ""
    @State var textFieldConfig1 = TextFieldConfig(title: "Enter your score",
                                                  placeholderText: "Enter score")
    @State var textFieldConfig2 = TextFieldConfig(title: "Enter opponent score",
                                                  placeholderText: "Enter score")
    
    var body: some View {
        VStack(spacing: 16) {
            MatchOptionView(title: "What was the match result?", option1: "I won", option2: "I lost", withToggling: true) { isPositive in
                
            }
            Divider()
            HStack(spacing: 12) {
                LoginTextFieldView(text: $score1, config: $textFieldConfig1, isSecure: false, fontSize: 15, keyboardType: .numberPad)
                LoginTextFieldView(text: $score2, config: $textFieldConfig2, isSecure: false, fontSize: 15, keyboardType: .numberPad)
            }
            Spacer()
            ButtonView(title: "Submit") {
                coordinator.dismiss()
                coordinator.push(.matchResult(Int(score1) ?? 1, Int(score2) ?? 2))
            }
        }
        .padding(.horizontal, 16)
        .background(Colors.Secondary.highlightBlack)
    }
}

struct MatchOptionView: View {
    
    let title: String
    let option1: String
    let option2: String
    var withToggling = false
    @State var firstOptionChoosed = false
    let optionTapped: (Bool) -> Void
    
    var body: some View {
        VStack {
            SheetsDragIndicator()
            Text(title)
                .font(AppFont.everettMedium.size(20))
                .foregroundColor(Colors.Primary.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer().frame(height: 40)
            HStack {
                ButtonView(title: option1, isPrimaryButton: firstOptionChoosed) {
                    if withToggling { firstOptionChoosed = true } else { optionTapped(false) }
                }
                ButtonView(title: option2, isPrimaryButton: !firstOptionChoosed) {
                    if withToggling { firstOptionChoosed = false } else { optionTapped(true) }
                }
            }
            Spacer()
        }
    }
}
