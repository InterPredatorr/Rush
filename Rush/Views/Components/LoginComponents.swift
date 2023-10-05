//
//  LoginViewComponents.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

struct ForgetPasswordButtonView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                coordinator.present(.forgotPassword)
                viewModel.forgotPasswordButtonTapped()
            } label: {
                Text("Forgot password")
                    .foregroundColor(Colors.Secondary.copyText)
                    .font(AppFont.everettRegular.size(15))
            }
        }
    }
}

struct LoginViewSignUpView: View {
    
    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
        VStack {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 0)
                    .frame(height: 1)
                    .foregroundColor(Colors.Opacity.line)
                Text("OR")
                    .foregroundColor(Colors.Primary.white)
                RoundedRectangle(cornerRadius: 0)
                    .frame(height: 1)
                    .foregroundColor(Colors.Opacity.line)
            }
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(Colors.Primary.white)
                    .font(AppFont.everettRegular.size(15))
                Button {
                    coordinator.push(.signUp)
                } label: {
                    Text("Sign up")
                        .foregroundColor(Colors.Primary.purpleA)
                        .font(AppFont.everettMedium.size(15))
                }

            }
            Spacer().frame(height: 20)
        }
    }
}

struct LoginTextFieldView: View {
    
    @Binding var text: String
    @Binding var config: TextFieldConfig
    let isSecure: Bool
    var isHideButtonNeeded: Bool = true
    var fontSize: CGFloat? = nil
    var keyboardType: UIKit.UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(config.title)
                .foregroundColor(Colors.Primary.white)
                .font(AppFont.everettMedium.size(fontSize ?? 17))
            Spacer().frame(height: 6.5)
            TextFieldView(config: config,
                              text: $text,
                              isSecure: isSecure,
                              isHideButtonNeeded: isHideButtonNeeded,
                              keyboardType: keyboardType)
                .autocorrectionDisabled()
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

