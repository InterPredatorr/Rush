//
//  NotificationsScreen.swift
//  Rush
//
//  Created by Aziz on 26.08.23.
//

import SwiftUI

struct NotificationItem: Identifiable {
    var id = UUID()
    let title: String
    let receiveDate: String
    let image: String
}

struct NotificationsScreen: View {
    
    let notificationsData: [NotificationItem] = [
        .init(title: "Shanon Moriellis accepted your match request to play FIFA 2023 on June 28, 2023.",
              receiveDate: "05 Jan 2023 | 10:00 AM",
              image: "TabImage4"),
        .init(title: "Joker liked your match result against 777silo.",
              receiveDate: "05 Jan 2023 | 10:00 AM",
              image: "Like"),
        .init(title: "Joker commented ‘you’re a legend’ against 777silo.",
              receiveDate: "05 Jan 2023 | 10:00 AM",
              image: "Chat")]
    
    var body: some View {
        VStack {
            header
            notifications
        }
        .padding()
        .background(Colors.Primary.black.ignoresSafeArea())
    }
}

extension NotificationsScreen {
    
    
    
    var header: some View {
        HeaderView(title: "Notifications")
    }
    
    var notifications: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(notificationsData) { item in
                    NotificationItemView(item: item)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Colors.Opacity.line)
                }
            }
            .padding(.vertical, 16)
            Spacer()
        }
    }
}

struct NotificationItemView: View {
    
    let item: NotificationItem
    
    var body: some View {
        HStack(spacing: 12) {
            VStack {
                Image(item.image)
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                    .padding(8)
                    .foregroundColor(Colors.Primary.blue)
                    .background(
                        Colors.Opacity.b
                            .cornerRadius(20)
                            .frame(width: 40, height: 40)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 1)
                                    .fill(Colors.Primary.blue)
                            }
                    )
                Spacer()
            }
            .padding(.leading, 2)
            VStack(alignment: .leading, spacing: 16) {
                Text(item.title)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(AppFont.everettRegular.size(15))
                Text(item.receiveDate)
                    .font(AppFont.everettRegular.size(11))
                    .foregroundColor(Colors.Secondary.copyText)
            }
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.vertical, 16)
    }
}

struct NotificationsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsScreen()
    }
}
