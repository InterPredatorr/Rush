//
//  LoginViewModel.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import Foundation

enum RequestState {
    case success
    case failure
    case none
}

class LoginViewModel: ObservableObject {
    
    let networkManager = NetworkManager()
    
    @Published var loginConfig = SettingsManager.shared.login
    @Published var loginModel: LoginModel
    
    init() {
        self.loginModel = LoginModel(email: "", password: "")
    }
    
    var isAllowedToGoForward: Bool {
        loginModel.email.isValidEmail
    }
    
    func signInButtonTapped() {
        // TODO:
    }
    
    func forgotPasswordButtonTapped() {
        // TODO:
    }
}
