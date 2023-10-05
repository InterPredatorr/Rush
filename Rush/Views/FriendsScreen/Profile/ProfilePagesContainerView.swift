//
//  ProfilePagesContainerView.swift
//  Rush
//
//  Created by Aziz on 08.08.23.
//

import SwiftUI

struct ProfilePagesContainerView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @State var profileActionType: ProfileActionType
    
    var body: some View {
        VStack {
            header
            switch profileActionType {
            case .editProfile:
                ProfileEditView()
            case let .wallet(tab):
                ProfileWalletView(profileActionType: $profileActionType, currentTab: tab)
            case .withdraw:
                ProfileWithdrawPaymentView(profileActionType: $profileActionType)
            case .followersFriends:
                EmptyView()
            case .films:
                ProfileFilmsView()
            case .disputs:
                ProfileDisputsView()
            case .settings:
                EmptyView()
            case .none:
                EmptyView()
            }
        }
        .padding()
    }
    
    func titleForPage(with type: ProfileActionType) -> String {
        switch type {
        case .editProfile:
            return "Edit Profile"
        case .wallet:
            return "Wallet"
        case .followersFriends:
            return "Followers and Friends"
        case .films:
            return "Films"
        case .disputs:
            return "Disputes"
        case .settings:
            return "Settings"
        case .withdraw:
            return "Withdraw amount"
        case .none:
            return ""
        }
    }
}

struct ProfileTabItem: Identifiable, Equatable {
    var id = UUID()
    let title: String
    var isSelected: Bool
}

private extension ProfilePagesContainerView {
    
    var header: some View {
        HeaderView(title: titleForPage(with: profileActionType)) {
            HStack {
                Spacer()
                Circle()
                    .fill(Colors.Secondary.highlightBlack)
                    .frame(width: 40, height: 40)
                    .overlay(Image("threeDots"))
                    .onTapGesture {
                        coordinator.present(.profileMenu, size: .medium)
                    }

            }
        }
    }
}
