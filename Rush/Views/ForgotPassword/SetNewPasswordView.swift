//
//  SetNewPasswordView.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

struct SetNewPasswordView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel: ForgotPasswordViewModel
    
    var body: some View {
        VStack {
            ForgotPasswordTopView(imageName: ImageResources.forgotPasswordPurple,
                                  title: viewModel.forgotPasswordConfig.setNewPassword.title,
                                  description: viewModel.forgotPasswordConfig.setNewPassword.description)
            Spacer().frame(height: 40)
            LoginTextFieldView(text: $viewModel.forgotPasswordModel.newPassword,
                               config: $viewModel.loginConfig.password,
                               isSecure: true,
                               isHideButtonNeeded: false)
            Spacer().frame(height: 8)
            if !viewModel.isValidPassword {
                SetNewPasswordRequirementsView()
            }
            Spacer().frame(height: 20)
            LoginTextFieldView(text: $viewModel.forgotPasswordModel.newPasswordConfirm,
                               config: $viewModel.loginConfig.confirmPassword,
                               isSecure: true,
                               isHideButtonNeeded: false)
            Spacer().frame(height: 24)
            ButtonView(title: "Reset Password") {
                withAnimation {
                    coordinator.dismiss()
                    viewModel.resetButtonTapped()
                }
            }
            .disabled(!viewModel.isValidPassword)
            .opacity(viewModel.isValidPassword ? 1 : 0.5)
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .background(Colors.Primary.black)
        .padding(.horizontal, 16)
    }
}

struct SetNewPasswordRequirementsView: View {
    
    private let reqs = ["Must be at least 6 characters.",
                        "At least one special character (e.g *!^$@).",
                        "At least one lowercase letter.",
                        "At least one uppercase letter."]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<reqs.count, id: \.self) { i in
                HStack {
                    Image(systemName: "circlebadge.fill")
                        .resizable()
                        .frame(width: 4, height: 4)
                        .foregroundColor(Colors.Primary.white)
                    Text(reqs[i])
                        .foregroundColor(Colors.Primary.white)
                        .font(AppFont.everettRegular.size(15))
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
