//
//  FriendsOnline.swift
//  Rush
//
//  Created by aziz on 2023-07-29.
//

import SwiftUI

struct FriendsOnlineScreen: View {    
    var body: some View {
        ZStack {
            Colors.Primary.black
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                header
                inboxView
                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
    }
}

private extension FriendsOnlineScreen {
    var header: some View {
        HeaderView(title: "Friends Online (45)") {
            Circle()
                .fill(Colors.Secondary.highlightBlack)
                .frame(width: 40, height: 40)
                .overlay(Image("search"))
        }
    }
    
    var inboxView: some View {
        RoundedView {
            VStack() {
                NavigationLink(value: Page.profile) {
                    inboxItemFor("S. Curran", time: "3 hours ago", imageName: "curran")
                }
                NavigationLink(value: Page.profile) {
                    inboxItemFor("Soni Gill", time: "11 hours ago", imageName: "soni")
                }
                NavigationLink(value: Page.profile) {
                    inboxItemFor("K. Pandya", time: "yesterday", imageName: "pandya")
                }
            }
        }
    }
    
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
}

struct FriendsOnlineScreen_Previews: PreviewProvider {
    static var previews: some View {
        FriendsOnlineScreen()
            .environmentObject(Coordinator())
    }
}
