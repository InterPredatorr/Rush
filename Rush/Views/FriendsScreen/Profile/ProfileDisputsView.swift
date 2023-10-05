//
//  ProfileDisputsView.swift
//  Rush
//
//  Created by Aziz on 08.08.23.
//

import SwiftUI

struct ProfileDisputsView: View {

    @State var disputTypes: [ProfileTabItem] = [.init(title: "Ongoing", isSelected: true),
                                                .init(title: "Pending", isSelected: false),
                                                .init(title: "Cleared", isSelected: false)]
    
    var body: some View {
        VStack(spacing: 30) {
            ProfileTabsView(types: $disputTypes)
            ScrollView {
                ForEach(0..<3) { i in
                    DisputPageitemView()
                }
            }
            .refreshable {}
            Spacer()
        }
        .padding(.top, 30)
    }
}

struct DisputPageitemView: View {
    
    let title = "FIFA"
    let subtitle = "With Player Xino - 2 days ago"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(ImageResources.fifa)
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
                Spacer().frame(width: 12)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(AppFont.everettMedium.size(20))
                        .foregroundColor(Colors.Primary.white)
                    Spacer().frame(height: 4)
                    Text(subtitle)
                        .font(AppFont.everettRegular.size(14))
                        .foregroundColor(Colors.Secondary.copyText)
                }
                Spacer()
                Image("message")
                    .resizable()
                    .foregroundColor(Colors.Secondary.copyText)
                    .frame(width: 24, height: 24)
            }
            .padding([.horizontal, .top], 16)
            Divider()
                .padding(.horizontal, 16)
                .foregroundColor(Colors.Secondary.copyText)
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 135, height: 35)
                .foregroundColor(Colors.Opacity.b)
                .overlay {
                    Text("Both said I won")
                        .font(AppFont.everettMedium.size(13))
                        .foregroundColor(Colors.Primary.white)
                }
                .padding([.horizontal, .bottom], 16)
        }
        .background(Colors.Secondary.highlightBlack)
        .cornerRadius(16)
    }
}
