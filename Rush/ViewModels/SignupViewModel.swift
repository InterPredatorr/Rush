//
//  SignupViewModel.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import Foundation

enum SignupSteps: Int {
    case email
    case confirmCode
    case fullname
    case username
    case password
}

class SignupViewModel: ObservableObject {
    
    @Published var signupModel: SignupModel
    @Published var signupConfig = SettingsManager.shared.signup
    @Published var currentPage: SignupSteps = .email
    @Published var confirmationCode: String = ""
    
    init() {
        signupModel = .init(email: "", fullname: "", username: "", password: "")
    }
    
    func continueButtonTapped() {
        if currentPage == .password { return }
        currentPage = SignupSteps(rawValue: currentPage.rawValue + 1)!
    }
    
    func backButtonTapped() {
        if currentPage == .email { return }
        currentPage = SignupSteps(rawValue: currentPage.rawValue - 1)!
    }
    
    func singInButtonTapped() {
        
    }
    
    func makeDescriptionChanges(with email: String) {
        var newEmail = email
        _ = newEmail.popLast()
        if signupConfig.confirmEmail.description.contains(newEmail) {
            signupConfig.confirmEmail.description.replace(newEmail, with: email)
        }
    }
}
