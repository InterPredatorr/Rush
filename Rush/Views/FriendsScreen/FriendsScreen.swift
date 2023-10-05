//
//  FriendsScreen.swift
//  Rush
//
//  Created by aziz on 2023-07-28.
//

import SwiftUI

enum Route: Hashable {
    case search
    case referral
    case online
}

struct FriendsScreen: View {
    var body: some View {
        ZStack {
            Colors.Primary.black
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                HStack {
                    Text("Friends")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 24, weight: .medium))
                    Spacer()
                    NavigationLink(value: Page.searchFriends) {
                        Circle()
                            .fill(Colors.Secondary.highlightBlack)
                            .frame(width: 40, height: 40)
                            .overlay(Image("search"))
                    }
                }
                
                ScrollView {
                    VStack(spacing: 30) {
                        NavigationLink(value: Page.referral) {
                            referralView
                        }
                        .buttonStyle(.plain)
                        
                        NavigationLink(value: Page.friendsOnline) {
                            friendsOnlineView
                        }
                        .buttonStyle(.plain)
                        
                        unreadMessagesView
                        disputesView
                        inboxView
                        Spacer()
                    }
                }
            }
            .padding([.horizontal, .top])
        }
    }
}

private extension FriendsScreen {
    var referralView: some View {
        RoundedView {
            HStack {
                Text("Refer a friend\nand earn 5 tokens")
                    .foregroundColor(Colors.Primary.white)
                    .font(.system(size: 20, weight: .medium))
                Spacer()
                Image(ImageResources.referralCoin)
            }
        }
    }
    
    var friendsOnlineView: some View {
        RoundedView {
            VStack(spacing: 0) {
                TitleView("Friends online")
                Seperator()
                HStack() {
                    onlineFriendItem("Soni Gill", imageName: "soni")
                    Spacer()
                    onlineFriendItem("K. Pandya", imageName: "pandya")
                    Spacer()
                    onlineFriendItem("S. Curran", imageName: "curran")
                }
            }
            
        }
    }
    
    var unreadMessagesView: some View {
        RoundedView {
            VStack(spacing: 0) {
                HStack {
                    Text("Unread messages")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 20, weight: .medium))
                    Pill(.rectangular, text: "6 new")
                    Spacer()
                    Image(ImageResources.arrowRight)
                }
                
                Seperator()
                
                VStack {
                    NavigationLink(value: Page.chat) {
                        HStack(spacing: 16) {
                            Image("curran")
                            Text("S. Curran")
                                .foregroundColor(Colors.Primary.white)
                                .font(.system(size: 20, weight: .medium))
                            Spacer()
                            Pill(.circular, text: "2")
                        }
                    }
                    
                    NavigationLink(value: Page.chat) {
                        HStack(spacing: 16) {
                            Image("soni")
                            Text("Soni Gill")
                                .foregroundColor(Colors.Primary.white)
                                .font(.system(size: 20, weight: .medium))
                            Spacer()
                            Pill(.circular, text: "3")
                        }
                    }
                }
                
            }
        }
    }
    
    var disputesView: some View {
        RoundedView {
            VStack(spacing: 0) {
                TitleView("Disputes", detail: "1 new update")
                Seperator()
                HStack {
                    Image("fifa")
                    VStack(alignment: .leading) {
                        Text("FIFA game")
                            .foregroundColor(Colors.Primary.white)
                            .font(.system(size: 20, weight: .medium))
                        Text("with Xing Shu")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 13, weight: .medium))
                    }
                    Spacer()
                    
                    Text("11/10/20")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 13, weight: .medium))
                        .padding(.trailing, 20)
                    
                    Pill(.circular, text: "1")
                }
            }
            
        }
    }
    
    var inboxView: some View {
        RoundedView {
            VStack(spacing: 0) {
                TitleView("Inbox")
                Seperator()
                VStack {
                    inboxItemFor("S. Curran", time: "3 hours ago", imageName: "curran")
                    inboxItemFor("Soni Gill", time: "11 hours ago", imageName: "soni")
                    inboxItemFor("K. Pandya", time: "yesterday", imageName: "pandya")
                }
            }
        }
    }
}

private extension FriendsScreen {
    func inboxItemFor(_ name: String, time: String, imageName: String) -> some View {
        RoundedView(color: Colors.Primary.black) {
            HStack {
                Image(imageName)
                VStack(alignment: .leading) {
                    HStack {
                        Text(name)
                            .foregroundColor(Colors.Primary.white)
                            .font(.system(size: 20, weight: .medium))
                        Spacer()
                        
                        Text(time)
                            .foregroundColor(Color.gray)
                            .font(.system(size: 13, weight: .medium))
                    }
                    
                    Text("Lorem ipsum is placeholder text commonly used in the graphic.")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 15, weight: .medium))
                }
            }
        }
    }
    
    func onlineFriendItem(_ name: String, imageName: String) -> some View {
        VStack {
            Image(imageName)
            Text(name)
                .foregroundColor(Colors.Primary.white)
                .font(.system(size: 20, weight: .medium))
        }
    }
}

struct TitleView: View {
    let title: String
    var detail: String?
    
    init(_ title: String, detail: String? = nil) {
        self.title = title
        self.detail = detail
    }
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Colors.Primary.white)
                .font(.system(size: 20, weight: .medium))
            if let detail {
                Pill(.rectangular, text: detail)
            }
            Spacer()
            Image(ImageResources.arrowRight)
        }
    }
}

struct Pill: View {
    enum `Type` {
        case circular, rectangular, rectangularFilledBlue, rectangularFilledBlack
    }
    
    let type: `Type`
    let text: String
    var textColor: Color?
    
    init(_ type: `Type` = .rectangular, text: String, textColor: Color? = nil) {
        self.type = type
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        switch type {
        case .circular:
            Circle()
                .strokeBorder(Colors.Opacity.line, lineWidth: 1)
                .background(Circle().fill(Colors.Primary.black))
                .frame(width: 24, height: 24)
                .overlay(
                    Text(text)
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 13, weight: .medium))
                    
                )
        case .rectangular:
            Text(text)
                .foregroundColor(textColor ?? Colors.Primary.blue)
                .font(.system(size: 11, weight: .medium))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Colors.Primary.blue.opacity(0.3))
                .cornerRadius(22)
                .overlay(RoundedRectangle(cornerRadius: 22)
                    .stroke(Colors.Primary.blue, lineWidth: 1))
            
        case .rectangularFilledBlue:
            Text(text)
                .foregroundColor(textColor ?? Colors.Primary.white)
                .font(.system(size: 11, weight: .medium))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Colors.Primary.blue)
                .cornerRadius(22)
                .overlay(RoundedRectangle(cornerRadius: 22)
                    .stroke(Colors.Primary.blue, lineWidth: 1))
        case .rectangularFilledBlack:
            Text(text)
                .foregroundColor(textColor ?? Colors.Primary.white)
                .font(.system(size: 11, weight: .medium))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Colors.Secondary.highlightBlack)
                .cornerRadius(22)
                .overlay(RoundedRectangle(cornerRadius: 22)
                    .stroke(Colors.Opacity.line, lineWidth: 1))
        }
    }
}

struct Seperator: View {
    var body: some View {
        VStack {
            Colors.Opacity.line
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
        }
    }
}

struct RoundedView<Content>: View where Content: View {
    let color: Color
    let cornerRadius: CGFloat
    let contentView: Content
    
    init(color: Color = Colors.Secondary.highlightBlack, cornerRadius: CGFloat = 16, content: () -> Content) {
        self.color = color
        self.cornerRadius = cornerRadius
        self.contentView = content()
    }
    
    var body: some View {
        contentView
        .padding()
        .background(color)
        .cornerRadius(cornerRadius)
        .overlay(RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(Colors.Opacity.line, lineWidth: 0.5))
    }
}

struct FriendsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack(path: .constant([Route]())) {
            FriendsScreen()
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .search:
                    FriendsSearchScreen()
                case .referral:
                    ReferralScreen()
                case .online:
                    FriendsOnlineScreen()
                }
            }
        }
    }
}
