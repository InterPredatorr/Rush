//
//  ForgotPasswordViewModell.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

enum ForgotPasswordCurrentView {
    case sendCode
    case insertCode
    case setNewPassword
}

class ForgotPasswordViewModel: ObservableObject {
    
    let forgotPasswordConfig = SettingsManager.shared.forgotPassword
    @Published var loginConfig = SettingsManager.shared.login
    @Published var currentView: ForgotPasswordCurrentView = .sendCode
    @Published var forgotPasswordModel: ForgotPasswordModel
    @Published var email: String = ""
    @Published var verificationCode: String = ""
    
    init() {
        self.forgotPasswordModel = ForgotPasswordModel(newPassword: "", newPasswordConfirm: "")
    }
    
    var isValidEmail: Bool {
        email.isValidEmail
    }
    
    var isValidPassword: Bool {
        forgotPasswordModel.newPassword == forgotPasswordModel.newPasswordConfirm && forgotPasswordModel.newPassword.isValidPassword
    }
    
    func getVerificationCodeButtonTapped() {
        currentView = .insertCode
    }
    
    func getVerificationCodeButtonTappedFromEmail() {
        currentView = .setNewPassword
    }
    
    func changeEmailButtonTapped() {
        currentView = .sendCode
    }
    
    func resendButtonTapped() {
        //
    }
    
    func resetButtonTapped() {
        //
    }
}
