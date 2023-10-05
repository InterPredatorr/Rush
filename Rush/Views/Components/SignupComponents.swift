//
//  SignupComponents.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

struct SignupBackButtonView: View {
    
    let buttonTapped: () -> Void
    private let buttonHeight = 40.0
    
    var body: some View {
        HStack {
            Button {
                buttonTapped()
            } label: {
                Image(systemName: ImageResources.backButton)
                    .frame(width: buttonHeight, height: buttonHeight)
                    .foregroundColor(Colors.Primary.white)
                    .background(Colors.Secondary.highlightBlack)
                    .cornerRadius(buttonHeight / 2)
            }
            Spacer()
        }
        .frame(height: buttonHeight)
        .frame(maxWidth: .infinity)
    }
}

struct SignupBottomView: View {
    
    let buttonTapped: () -> Void
    
    var body: some View {
        HStack {
            Text("Already have an account?")
                .foregroundColor(Colors.Primary.white)
                .font(AppFont.everettRegular.size(15))
            Button {
                buttonTapped()
            } label: {
                Text("Log in")
                    .foregroundColor(Colors.Primary.purpleA)
                    .font(AppFont.everettMedium.size(15))
            }

        }
    }
}
