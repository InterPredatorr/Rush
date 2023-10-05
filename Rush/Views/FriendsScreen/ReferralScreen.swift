//
//  ReferralScreen.swift
//  Rush
//
//  Created by aziz on 2023-07-29.
//

import SwiftUI

struct ReferralScreen: View {
    @State private var text = ""
    
    var body: some View {
        ZStack {
            Colors.Primary.black
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                header
                RoundedView {
                    VStack {
                        HStack {
                            Text("My Referral link")
                                .foregroundColor(Colors.Primary.white)
                                .font(.system(size: 20, weight: .medium))
                            Spacer()
                            Image("share")
                        }
                        
                        seperator
                            .padding(.vertical, 12)
                        
                        RoundedView(color: Colors.Primary.black, cornerRadius: 40) {
                            TextField("", text: $text, prompt: Text("Enter code here").foregroundColor(.gray))
                                .foregroundColor(Colors.Primary.white)
                                .font(.system(size: 20, weight: .medium))
                                .padding(.horizontal)
                            
                        }
                    }
                    
                }
                
                friendsJoinedView
                
                
                Spacer()
                
                
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
    }
}

private extension ReferralScreen {
    var header: some View {
        HeaderView(title: "Referral") {
            HStack {
                Image(ImageResources.referralCoin)
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("100")
                    .foregroundColor(Colors.Primary.white)
                    .font(.system(size: 15, weight: .medium))
            }
        }
    }
    
    var seperator: some View {
        Colors.Opacity.line
            .frame(height: 1)
    }
    
    var friendsJoinedView: some View {
        RoundedView {
            VStack(spacing: 0) {
                NavigationLink(value: Page.friendsOnline) {
                    TitleView("Friends online")
                }
                Seperator()
                HStack {
                    joinedFriendItem("Soni Gill", imageName: "soni")
                    Spacer()
                    joinedFriendItem("K. Pandya", imageName: "pandya")
                    Spacer()
                    joinedFriendItem("S. Curran", imageName: "curran")
                }
            }
            
        }
    }
    
    func joinedFriendItem(_ name: String, imageName: String) -> some View {
        VStack {
            Image(imageName)
            Text(name)
                .foregroundColor(Colors.Primary.white)
                .font(.system(size: 20, weight: .medium))
            Text("+5 tokens")
                .foregroundColor(Color.gray)
                .font(.system(size: 14, weight: .medium))
        }
    }

}

struct ReferralScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReferralScreen()
            .environmentObject(Coordinator())
    }
}
