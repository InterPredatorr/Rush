//
//  CheckEmailView.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI
import Combine

struct CheckEmailView: View {
    
    @ObservedObject var viewModel: ForgotPasswordViewModel
    private let topSpacing = 40.0
    private let imageHeight = 70.0
    private let midItemSpace = 32.0
    
    var body: some View {
        VStack {
            VStack {
                ForgotPasswordTopView(imageName: ImageResources.forgotPasswordEmail,
                                      title: viewModel.forgotPasswordConfig.checkEmail.title,
                                      description: viewModel.forgotPasswordConfig.checkEmail.description,
                                      email: viewModel.email)
                Spacer().frame(height: imageHeight / 2)
                VerificationCodeBoxes(verificationCode: $viewModel.verificationCode)
                Spacer().frame(height: midItemSpace)
                CheckEmailButtonsView(viewModel: viewModel)
                Spacer().frame(height: midItemSpace)
                ChangeResetEmailView(viewModel: viewModel)
            }
            .padding(.horizontal, midItemSpace / 2)
            Spacer()
        }
        .background(Colors.Primary.black)
    }
}

struct VerificationCodeBoxes: View {
    
    @Binding var verificationCode: String
    
    var body: some View {
        OtpFormFieldView(pin: $verificationCode)
    }
}

struct CheckEmailButtonsView: View {
    
    @ObservedObject var viewModel: ForgotPasswordViewModel

    var body: some View {
        ButtonView(title: "Get verification code") {
            withAnimation {
                viewModel.getVerificationCodeButtonTappedFromEmail()
            }
        }
        .disabled(viewModel.verificationCode.count < 4)
        .opacity(viewModel.verificationCode.count == 4 ? 1 : 0.5)
        Spacer().frame(height: 16)
        ButtonView(title: "Change Email", isPrimaryButton: false) {
            withAnimation {
                viewModel.changeEmailButtonTapped()
            }
        }
    }
}

struct ChangeResetEmailView: View {
    
    @ObservedObject var viewModel: ForgotPasswordViewModel
    
    var body: some View {
        HStack {
            Text("Didn't receive the email?")
                .font(AppFont.everettRegular.size(15))
                .foregroundColor(Colors.Primary.white)
            Spacer().frame(width: 4)
            Text("Click to resend")
                .font(AppFont.everettMedium.size(15))
                .foregroundColor(Colors.Primary.purpleA)
                .onTapGesture {
                    viewModel.resendButtonTapped()
                }
        }
    }
}
