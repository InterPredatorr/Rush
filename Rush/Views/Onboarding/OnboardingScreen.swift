//
//  OnboardingScreen.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

struct OnboardingScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Colors.Gradients.onboardingGradient,
                           startPoint: .top,
                           endPoint: .bottom)
            VStack {
                Spacer()
                Image("OnboardingImage")
                    .resizable()
                    .frame(height: 60)
                    .padding(.horizontal, 96)
                Spacer()
            }
        }
        .ignoresSafeArea()
        .task {
            await dismiss()
        }
    }
    
    func dismiss() async {
        let onboardingShowTime: UInt64 = 1_000_000_000
        try? await Task.sleep(nanoseconds: onboardingShowTime)
        coordinator.popToRoot()
        coordinator.present(fullScreenCover: .splash)
        try? await Task.sleep(nanoseconds: onboardingShowTime / 3)
        coordinator.push(.login)
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
            .environmentObject(Coordinator())
    }
}
