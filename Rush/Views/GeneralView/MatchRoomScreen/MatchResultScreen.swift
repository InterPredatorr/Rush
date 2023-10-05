//
//  MatchResultScreen.swift
//  Rush
//
//  Created by Aziz on 12.08.23.
//

import SwiftUI

struct MatchResultScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    let score1: Int
    let score2: Int
    let textFieldConfig = TextFieldConfig(title: "", placeholderText: "Type here...")
    @State var fieldText = ""
    @State var isCurrentViewDisputs = false
    
    var body: some View {
        VStack {
            header
            Spacer().frame(height: 60)
            if isCurrentViewDisputs {
                MatchDisputsView()
            } else {
                mainContent
                Spacer().frame(height: 60)
                bottomView
                Spacer()
            }
        }
        .padding(.horizontal, 16)
    }
}


private extension MatchResultScreen {
    
    var header: some View {
        HeaderView(title: "Match result") {
            HStack {
                if isCurrentViewDisputs {
                    Spacer()
                    Button {
                        coordinator.pop()
                    } label: {
                        Text("Done")
                            .foregroundColor(Colors.Primary.white)
                            .font(AppFont.everettMedium.size(17))
                    }

                }
            }
        }
    }
    
    var mainContent: some View {
        GeometryReader { reader in
            VStack(alignment: .center) {
                Spacer().frame(height: 50)
                Image("soni")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("Nevergaveup")
                    .font(AppFont.everettMedium.size(24))
                    .foregroundColor(Colors.Primary.white)
                    .frame(height: 30)
                Spacer().frame(height: 6)
                Text("Won $70")
                    .font(AppFont.everettRegular.size(20))
                    .foregroundColor(Colors.Secondary.copyText)
                    .frame(height: 30)
                Spacer().frame(height: 24)
                HStack {
                    Text("A. Madrid")
                        .font(AppFont.everettMedium.size(13))
                        .foregroundColor(Colors.Primary.white)
                    Spacer()
                    Text("\(score1) - \(score2)")
                        .font(AppFont.everettMedium.size(24))
                        .foregroundColor(Colors.Primary.purpleB)
                    Spacer()
                    Text("Chelsea")
                        .font(AppFont.everettMedium.size(13))
                        .foregroundColor(Colors.Primary.white)
                }
                .frame(height: 30)
                Spacer().frame(height: 20)
                TextFieldView(config: textFieldConfig, text: $fieldText, isSecure: false, cornerRadius: 100, background: Colors.Primary.black)
                    .overlay {
                        HStack {
                            Spacer()
                            Button {
                                //
                            } label: {
                                Image(systemName: "smiley.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Colors.Primary.white)
                            }
                            Spacer().frame(width: 10)
                        }
                    }
            }
            .padding(.all, 16)
            .background(Colors.Secondary.highlightBlack)
            .cornerRadius(16)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .fill(Colors.Opacity.line)
                Text("Winner")
                    .font(AppFont.everettMedium.size(20))
                    .foregroundColor(Colors.Primary.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 55)
                    .background(Colors.Primary.blue)
                    .cornerRadius(100)
                    .position(x: reader.size.width / 2, y: 0)
                    
            }
        }
        .frame(height: UIScreen.main.bounds.height / 2.5)
    }
    
    var bottomView: some View {
        VStack(alignment: .center) {
            Text("Processing game statistics and film...")
                .font(AppFont.everettMedium.size(17))
                .foregroundColor(Colors.Primary.white)
            Spacer().frame(height: 12)
            Text("This can take up to 24-48 hours.")
                .font(AppFont.everettRegular.size(13))
                .foregroundColor(Colors.Secondary.copyText)
            Spacer()
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Image("share")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .background {
                            Circle()
                                .stroke(lineWidth: 1)
                                .fill(Colors.Primary.blue)
                                .frame(width: 40, height: 40)
                                .background(Colors.Opacity.b)
                                .cornerRadius(20)
                        }
                }
            }
            .padding(.horizontal, -5)
            Spacer().frame(height: 42)
            ButtonView(title: "Back to match room") {
                withAnimation {
                    isCurrentViewDisputs.toggle()
                }
            }
        }
    }
}


struct MatchDisputsView: View {
    
    var body: some View {
        VStack {
            Image("soni")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(50)
            Spacer().frame(height: 40)
            Text("Both players said I won")
                .font(AppFont.everettMedium.size(17))
                .foregroundColor(Colors.Primary.white)
                .padding(.vertical, 16)
                .padding(.horizontal, 80)
                .background {
                    Colors.Secondary.highlightBlack
                }
                .cornerRadius(12)
            Spacer().frame(height: 30)
            Text("If your dispute claim is found true, your game token and game stake will be returned to your account. If found false by the review team, your token and stake will not be returned")
                .multilineTextAlignment(.leading)
                .font(AppFont.everettRegular.size(13))
                .foregroundColor(Colors.Primary.white)
            Spacer()
            ButtonView(title: "I was wrong") {
                //
            }
            Spacer().frame(height: 20)
            ButtonView(title: "Create dispute", backgroundColor: Colors.Secondary.highlightBlack, borderColor: Colors.Primary.purpleA, textColor: Colors.Primary.purpleA, isPrimaryButton: false) {
                //
            }
        }
    }
}
