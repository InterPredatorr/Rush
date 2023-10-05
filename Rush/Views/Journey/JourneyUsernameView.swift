//
//  JourneyUsernameView.swift
//  Rush
//
//  Created by Aziz on 29.07.23.
//

import SwiftUI

struct JourneyUsernameView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @Binding var currentView: JourneyViewModel.CurrentView
    let itemConfig: ItemConfig
    @Binding var text: String
    
    var body: some View {
        VStack {
            BackButtonView {
                withAnimation {
                    currentView = .games
                }
            }
            Spacer().frame(height: 30)
            Text(itemConfig.title)
                .font(AppFont.everettMedium.size(24))
                .foregroundColor(Colors.Primary.white)
            Spacer().frame(height: 12)
            Text(itemConfig.description)
                .font(AppFont.everettRegular.size(15))
                .foregroundColor(Colors.Secondary.copyText)
            Spacer().frame(height: 40)
            TextFieldView(config: itemConfig.textFieldConfig,
                              text: $text,
                              isSecure: false)
            Spacer().frame(height: 30)
            ButtonView(title: "Next") {
                withAnimation {
                    coordinator.push(.follow)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(Colors.Primary.black)
    }
}
