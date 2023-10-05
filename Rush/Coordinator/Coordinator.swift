//
//  Coordinator.swift
//  ReservationApp
//
//  Created by Aziz on 16.07.23.
//

import SwiftUI

enum Page: Identifiable, Hashable {
    case onboarding
    case splash
    case login
    case signUp
    case journey
    case follow
    case buyCoins
    case general
    case referral
    case profile
    case profilePages(ProfileActionType)
    case friendsOnline
    case chat
    case searchFriends
    case currentMatch
    case matchResult(Int, Int)
    case notifications
    case joinRequest
    case createMatch
    case matchRequest(CreateMatchDetailView.SelectedGameMode)
    
    var id: String {
        UUID().uuidString
    }
}

enum Sheet: Identifiable {
    
    case forgotPassword
    case login
    case requestToPlay(Bool)
    case startMatch
    case endMatch
    case scoreInput
    case profileMenu
    case filterScreen
    
    var id: String {
        UUID().uuidString
    }

}

enum FullScreenCover: String, Identifiable {
    
    case splash
    case journey
    case buyCoins
    
    var id: String {
        self.rawValue
    }
}

class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var sheetSize: PresentationDetent?
    @Published var fullScreenCover: FullScreenCover?
    var onSheetDismiss: (() -> Void)?
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func present(_ sheet: Sheet, size: PresentationDetent? = nil, onSheetDismiss: (() -> Void)? = nil) {
        self.onSheetDismiss = onSheetDismiss
        self.sheet = sheet
        self.sheetSize = size
    }
    
    func present(fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismiss() {
        onSheetDismiss?()
        onSheetDismiss = nil
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .onboarding:
            OnboardingScreen()
        case .splash:
            SplashScreen()
        case .login:
            LoginScreen(viewModel: LoginViewModel())
        case .signUp:
            SignupScreen(viewModel: SignupViewModel())
        case .journey:
            JourneyScreen(viewModel: JourneyViewModel())
        case .follow:
            FollowOthersScreen(viewModel: FollowOthersViewModel())
        case .buyCoins:
            BuyCoinsScreen(viewModel: BuyCoinsViewModel(), isSheet: false)
        case .general:
            GeneralScreen()
        case .referral:
            ReferralScreen()
        case .friendsOnline:
            FriendsOnlineScreen()
        case .searchFriends:
            FriendsSearchScreen()
        case .chat:
            ChatScreen()
        case .profile:
            ProfileScreen()
        case let .profilePages(page):
            ProfilePagesContainerView(profileActionType: page)
        case .currentMatch:
            CurrentMatchScreen()
        case let .matchResult(s1, s2):
            MatchResultScreen(score1: s1, score2: s2)
        case .notifications:
            NotificationsScreen()
        case .joinRequest:
            JoinRequestScreen()
        case .createMatch:
            CreateMatchScreen()
        case let .matchRequest(gameMode):
            MatchRequestScreen(gameMode: gameMode)
        }
    }
    
    func sheetPresentationDetent() -> PresentationDetent? {
        return sheetSize
    }
    
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .login:
            LoginScreen(viewModel: LoginViewModel())
        case .forgotPassword:
            ForgotPasswordScreen(viewModel: ForgotPasswordViewModel())
        case let .requestToPlay(tokenBought):
            RequestToPlayScreen(tokenBought: tokenBought)
        case .startMatch:
            StartMatchSheetView()
        case .endMatch:
            EndMatchSheetView()
        case .scoreInput:
            ScoreInputSheetView()
        case .profileMenu:
            ProfileActionsMenuScreen()
        case .filterScreen:
            LeaderboardFilterView()
        }
    }
    
    @ViewBuilder
    func build(fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .splash:
            SplashScreen()
        case .journey:
            JourneyScreen(viewModel: JourneyViewModel())
        case .buyCoins:
            BuyCoinsScreen(viewModel: BuyCoinsViewModel(), isSheet: true)
        }
    }
}
