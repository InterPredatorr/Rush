//
//  LoginScreen.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel: LoginViewModel

    private let stdHeight = UIScreen.main.bounds.height / 10
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Colors.Gradients.loginGradient,
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer().frame(height: 60)
                Image(ImageResources.appMain)
                    .resizable()
                    .frame(height: stdHeight)
                    .padding(.horizontal, 60)
                Spacer().frame(height: stdHeight)
                LoginView(viewModel: viewModel)
                Spacer()
            }
        }
    }
}
