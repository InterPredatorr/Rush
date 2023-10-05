//
//  ProfileScreen.swift
//  Rush
//
//  Created by aziz on 2023-07-29.
//

import SwiftUI
import Charts

struct ProfileScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    var isTabView = false
    
    var body: some View {
        ZStack {
            Colors.Primary.black
                .ignoresSafeArea()
            VStack(spacing: 24) {
                header
                ProfileMainView()
            }
            .padding([.horizontal, .top])
        }
    }
}

private extension ProfileScreen {
    var header: some View {
        HeaderView(title: "nolimit555", titleOffset: -32, isTabView: isTabView) {
            HStack {
                ButtonView(title: "Follow", height: 33, font: AppFont.everettMedium.size(13), cornerRadius: 8) {
                    //
                }
                .frame(width: 75)
                Circle()
                    .fill(Colors.Secondary.highlightBlack)
                    .frame(width: 40, height: 40)
                    .overlay(Image("threeDots"))
                    .onTapGesture {
                        withAnimation {
                            coordinator.present(.profileMenu, size: .fraction(0.5))
                        }
                    }
            }
        }
    }
}

struct ProfileActionItem {
    let name: String
    let imageName: String
    let actionType: ProfileActionType
}

enum ProfileActionType: Hashable {
    case editProfile
    case wallet(WalletTab = .earnings)
    case followersFriends
    case films
    case disputs
    case settings
    case withdraw
    case none
}

struct ProfileActionsMenuScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator

    let actions = [ProfileActionItem(name: "Edit Profile", imageName: "ProfileEdit", actionType: .editProfile),
                   ProfileActionItem(name: "Wallet", imageName: "ProfileWallet", actionType: .wallet()),
                   ProfileActionItem(name: "Followers/Friends", imageName: "ProfileFollowers", actionType: .followersFriends),
                   ProfileActionItem(name: "Films", imageName: "ProfileFilms", actionType: .films),
                   ProfileActionItem(name: "Disputes", imageName: "ProfileDisputs", actionType: .disputs),
                   ProfileActionItem(name: "Settings", imageName: "ProfileSettings", actionType: .settings)]
    
    var body: some View {
        VStack {
            SheetsDragIndicator()
            VStack(alignment: .leading) {
                ForEach(actions, id: \.name) { action in
                    Button {
                        coordinator.dismiss()
                        coordinator.push(.profilePages(action.actionType))
                    } label: {
                        ProfileMenuItemView(action: action)
                    }
                }
            }
            .background(Colors.Secondary.highlightBlack)
        }
        .padding(.horizontal, 16)
        .background(Colors.Secondary.highlightBlack)
    }
}

private struct ProfileMenuItemView: View {
    
    let action: ProfileActionItem
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 12) {
                Image(action.imageName)
                    .resizable()
                    .frame(width: 24, height: 24)
                Text(action.name)
                    .font(AppFont.everettMedium.size(17))
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(Colors.Primary.white)
            Divider()
        }
    }
}
