//
//  SignupScreen.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

struct SignupScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel: SignupViewModel
    private let midItemSpace = 30.0
    var body: some View {
        VStack {
            SignupBackButtonView {
                if viewModel.currentPage == .email {
                    coordinator.pop()
                    return
                }
                viewModel.backButtonTapped()
            }
            Spacer().frame(height: midItemSpace)
            if let data = getItemConfigAndText() {
                SignupContentView(currentPage: viewModel.currentPage,
                                  itemConfig: data.config,
                                  text: data.text)
            }
            Spacer().frame(height: midItemSpace)
            ButtonView(title: viewModel.currentPage == .password ? "Complete" : "Next") {
                viewModel.currentPage == .password ? coordinator.push(.journey) : viewModel.continueButtonTapped()
                
            }
            Spacer()
            SignupBottomView {
                coordinator.pop()
                viewModel.singInButtonTapped()
            }
            Spacer().frame(height: midItemSpace * 2)
        }
        .padding(.horizontal, 16)
        .background(Colors.Primary.black)
        .frame(maxHeight: .infinity)
        .onChange(of: viewModel.signupModel.email) { newEmail in
            viewModel.makeDescriptionChanges(with: newEmail)
        }
    }
    
    private func getItemConfigAndText() -> (config: ItemConfig, text: Binding<String>)? {
        switch viewModel.currentPage {
        case .email:
            return (config: viewModel.signupConfig.email,
                    text: $viewModel.signupModel.email)
        case .confirmCode:
            return (config: viewModel.signupConfig.confirmEmail,
                    text: $viewModel.confirmationCode)
        case .fullname:
            return (config: viewModel.signupConfig.fullname,
                    text: $viewModel.signupModel.fullname)
        case .username:
            return (config: viewModel.signupConfig.username,
                    text: $viewModel.signupModel.username)
        case .password:
            return (config: viewModel.signupConfig.password,
                    text: $viewModel.signupModel.password)
        }
    }
}

struct SignupContentView: View {
    
    let currentPage: SignupSteps
    let itemConfig: ItemConfig
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(itemConfig.title)
                .font(AppFont.everettMedium.size(24))
                .foregroundColor(Colors.Primary.white)
            Spacer().frame(height: 12)
            Text(itemConfig.description)
                .font(AppFont.everettRegular.size(15))
                .foregroundColor(Colors.Secondary.copyText)
            Spacer().frame(height: 40)
            Text(itemConfig.textFieldConfig.title)
                .font(AppFont.everettMedium.size(17))
                .foregroundColor(Colors.Primary.white)
            TextFieldView(config: itemConfig.textFieldConfig,
                              text: $text,
                              isSecure: currentPage == .password,
                              keyboardType: currentPage == .email ? .emailAddress : .default)
        }
    }
}

struct SignupScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignupScreen(viewModel: SignupViewModel())

    }
}
