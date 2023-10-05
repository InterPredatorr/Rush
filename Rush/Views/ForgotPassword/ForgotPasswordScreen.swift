//
//  ForgotPasswordScreen.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

struct ForgotPasswordScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel: ForgotPasswordViewModel
    
    var body: some View {
        VStack {
            switch viewModel.currentView {
            case .sendCode:
                ForgotPasswordView(viewModel: viewModel)
            case .insertCode:
                CheckEmailView(viewModel: viewModel)
            case .setNewPassword:
                SetNewPasswordView(viewModel: viewModel)
            }
        }
        .background(Colors.Primary.black)
    }
}
