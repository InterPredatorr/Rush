//
//  ForgotPasswordView.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel: ForgotPasswordViewModel
    private let imageHeight = 70.0
    
    var body: some View {
        VStack {
            VStack {
                ForgotPasswordTopView(imageName: ImageResources.forgotPasswordBlue,
                                      title: viewModel.forgotPasswordConfig.forgotPassword.title,
                                      description: viewModel.forgotPasswordConfig.forgotPassword.description)
                Spacer().frame(height: 40)
                LoginTextFieldView(text: $viewModel.email,
                                   config: $viewModel.loginConfig.email,
                                   isSecure: false,
                                   keyboardType: .emailAddress)
                Spacer().frame(height: imageHeight / 2)
                ButtonView(title: "Get verification code") {
                    withAnimation {
                        viewModel.getVerificationCodeButtonTapped()
                    }
                }
                .disabled(!viewModel.isValidEmail)
                .opacity(viewModel.isValidEmail ? 1 : 0.5)
            }
            .padding(.horizontal, 16)
            Spacer()
        }
        .background(Colors.Primary.black)
    }
}
