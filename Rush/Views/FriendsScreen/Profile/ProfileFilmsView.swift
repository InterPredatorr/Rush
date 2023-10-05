//
//  ProfileFilmsView.swift
//  Rush
//
//  Created by Aziz on 09.08.23.
//

import SwiftUI

struct ProfileFilmsView: View {
    var body: some View {
        VStack {
            ProfileFilmsItemView()
            Spacer()
        }
    }
}


struct ProfileFilmsItemView: View {
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                ProfileFilmsBadgeView()
                ProfileFilmsBadgeView()
                Spacer()
            }
            .padding(.top, 30)
        }
    }
}

struct ProfileFilmsBadgeView: View {
    
    let items: [ProfileCommentItem] = [.init(imageName: "soni",
                                             userName: "Lana Steinler",
                                             comment: "Thanks so much, happy with that.",
                                             time: "2 mins ago"),
                                       .init(imageName: "wong",
                                             userName: "Joe Root",
                                             comment: "It was an amazing game I would like to challenge for a game, It was an amazing game I would like to challenge for a game",
                                             time: "8 mins ago")]
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Text("FIFA 2020")
                    .font(AppFont.everettMedium.size(20))
                    .foregroundColor(Colors.Primary.white)
                Spacer()
                Text("12/05/2020")
                    .font(AppFont.everettRegular.size(13))
                    .foregroundColor(Colors.Secondary.copyText)
            }
            Image("FilmsBadge")
                .resizable()
                .frame(height: UIScreen.main.bounds.height / 5)
                .overlay {
                    LinearGradient(gradient: Colors.Gradients.gameGridGradient, startPoint: .bottom, endPoint: .top)
                }
                .cornerRadius(16)
            VStack(spacing: 16) {
                ForEach(items, id: \.userName) { item in
                    ProfileCommentItemView(item: item)
                    Divider()
                }
            }
            ButtonView(title: "Load more comments", backgroundColor: Colors.Opacity.b, borderColor: Colors.Primary.blue, isPrimaryButton: false) {
                //
            }
        }
        .padding(.horizontal, 2)
    }
}

struct ProfileCommentItem {
    let imageName: String
    let userName: String
    let comment: String
    let time: String
}

struct ProfileCommentItemView: View {
    
    let item: ProfileCommentItem
    
    var body: some View {
        HStack(alignment: .top) {
            Image(item.imageName)
                .resizable()
                .frame(width: 40, height: 40)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 1.5)
                        .fill(Colors.Secondary.highlightBlack)
                    Circle()
                        .fill(Colors.Primary.blue)
                        .frame(width: 10, height: 10)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 1.5)
                                .fill(Colors.Secondary.highlightBlack)
                        }
                        .position(x: 35, y: 35)
                    
                }
            Spacer().frame(width: 12)
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(item.userName)
                        .font(AppFont.everettMedium.size(20))
                        .foregroundColor(Colors.Primary.white)
                    Spacer()
                    Text(item.time)
                        .font(AppFont.everettRegular.size(13))
                        .foregroundColor(Colors.Secondary.copyText)
                }
                ExpandableText(text: item.comment, lineLimit: 2)
                    .font(AppFont.everettRegular.size(15))
                    .foregroundColor(Colors.Secondary.copyText)
            }
        }
    }
    
}

