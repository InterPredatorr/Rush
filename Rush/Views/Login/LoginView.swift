//
//  LoginView.swift
//  Rush
//
//  Created by aziz on 2023-07-28.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            LoginTextFieldView(text: $viewModel.loginModel.email,
                               config: $viewModel.loginConfig.email,
                               isSecure: false,
                               keyboardType: .emailAddress)
            Spacer().frame(height: 30)
            LoginTextFieldView(text: $viewModel.loginModel.password,
                               config: $viewModel.loginConfig.password,
                               isSecure: true)
            Spacer().frame(height: 25)
            ForgetPasswordButtonView(viewModel: viewModel)
            Spacer().frame(height: 30)
            ButtonView(title: "Login") {
                withAnimation {
                    coordinator.push(.general)
                    viewModel.signInButtonTapped()
                }
            }
            .disabled(!viewModel.isAllowedToGoForward)
            .opacity(viewModel.isAllowedToGoForward ? 1 : 0.5)
            Spacer().frame(height: 20)
            LoginViewSignUpView()
        }
        .padding(.horizontal, 16)
    }
}
