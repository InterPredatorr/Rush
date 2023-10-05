//
//  FriendsSearchScreen.swift
//  Rush
//
//  Created by aziz on 2023-07-29.
//

import SwiftUI

struct FriendsSearchScreen: View {
    @State private var query = ""
    
    var body: some View {
        ZStack {
            Colors.Primary.black
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                
                HeaderView(title: "Search")
                
                RoundedView {
                    HStack {
                        Image("search")
                        TextField("", text: $query, prompt: Text("Search...").foregroundColor(.gray))
                            .foregroundColor(Colors.Primary.white)
                            .font(.system(size: 20, weight: .medium))
                            .padding(.horizontal)
                        Circle()
                            .stroke(Colors.Opacity.line)
                            .frame(width: 32, height: 32)
                            .overlay(Image("filter"))
                    }
                }
                
                
                VStack(alignment: .leading) {
                    getSearchItemFor("Sonia Gill", username: "sonia_hill", imageName: "soni")
                    seperator
                    getSearchItemFor("S. Curran", username: "curran1232", imageName: "curran")
                    seperator
                    getSearchItemFor("Pandya S", username: "PandyaSKl", imageName: "pandya")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
    }
}

private extension FriendsSearchScreen {
    var seperator: some View {
        Colors.Opacity.line
            .frame(height: 1)
    }

    func getSearchItemFor(_ name: String, username: String, imageName: String) -> some View {
        HStack(spacing: 20) {
            Image(imageName)
            VStack( alignment: .leading, spacing: 8) {
                Text(username)
                    .foregroundColor(Colors.Primary.white)
                    .font(.system(size: 20, weight: .medium))
                Text(name)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 14, weight: .medium))
            }
        }
    }
}

struct FriendsSearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        FriendsSearchScreen()
    }
}
