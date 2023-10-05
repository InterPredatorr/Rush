//
//  ProfileWalletView.swift
//  Rush
//
//  Created by Aziz on 08.08.23.
//

import SwiftUI

enum WalletTab: Int {
    case earnings
//    case tokens
    case payments
}

struct ProfileWalletView: View {
    
    @Binding var profileActionType: ProfileActionType
    @State var currentTab: WalletTab
    @State var tabs: [ProfileTabItem] = [.init(title: "Earnings", isSelected: true),
                                         .init(title: "Tokens", isSelected: false),
                                         .init(title: "Payments", isSelected: false)]
    let earningsHistoryItems: [ProfileHistoryItem] = [.init(name: "FIFA 2023", date: "12/05/2021", imageName: "fifa", amount: "-4 coins"),
                                                      .init(name: "NHL 2019", date: "12/05/2021", imageName: "fifa", amount: "-8 coins"),
                                                      .init(name: "FIFA 2023", date: "12/05/2021", imageName: "fifa", amount: "-3 coins"),
                                                      .init(name: "NHL 2019", date: "12/05/2021", imageName: "fifa", amount: "-4 coins")]
//    let tokensHistoryItems: [ProfileHistoryItem] = [.init(name: "FIFA 2023", date: "12/05/2021", imageName: "fifa", amount: "-5 coins"),
//                                                    .init(name: "NHL 2019", date: "12/05/2021", imageName: "fifa", amount: "-12 coins"),
//                                                    .init(name: "FIFA 2023", date: "12/05/2021", imageName: "fifa", amount: "-14 coins"),
//                                                    .init(name: "NHL 2019", date: "12/05/2021", imageName: "fifa", amount: "-20 coins")]
    let transactionHistory: [ProfileHistoryItem] = [.init(name: "Withdraw", date: "12/05/2021", imageName: "Withdraw", amount: "$90.0"),
                                                    .init(name: "Topup", date: "12/05/2021", imageName: "Topup", amount: "$90.0"),
                                                    .init(name: "Bought coins", date: "12/05/2021", imageName: "BoughtCoins", amount: "$120.0")]
    
    let availablePaymentMethods: [PaymentMethodItem] = [.init(imageName: "paypal", methodName: "PayPal"),
                                                        .init(imageName: "card", methodName: "Credit/Debit Card")]

    
    var body: some View {
        VStack(spacing: 30) {
            ProfileTabsView(types: $tabs)
            switch currentTab {
            case .earnings:
                earningsTab
//            case .tokens:
//                tokensTab
            case .payments:
                paymentsTab
            }
        }
        .padding(.top, 30)
        .onChange(of: tabs) { newValue in
            if let index = newValue.firstIndex(where: { $0.isSelected }),
               let item = WalletTab(rawValue: index) {
                withAnimation {
                    currentTab = item
                }
            }
        }
        .onAppear {
            tabs = tabs.enumerated().map { (index, element) in
                var tmp = element
                tmp.isSelected = index == currentTab.rawValue
                return tmp
            }
        }
    }
}

private extension ProfileWalletView {

    var earningsTab: some View {
        VStack(spacing: 30) {
            EarningsWalletBadgeView()
            ProfileWalletHistoryView(title: "Earnings hostory", earnings: earningsHistoryItems)
            
            
            HStack {
                ButtonView(title: "Add Cash", backgroundColor: Colors.Primary.blue) {
                    withAnimation {
                        profileActionType = .withdraw
                    }
                }
                
                ButtonView(title: "Cash Out") {
                    withAnimation {
                        profileActionType = .withdraw
                    }
                }
            }
        }
    }
    
//    var tokensTab: some View {
//        VStack(spacing: 30) {
//            TokensWalletBadgeView()
//            ProfileWalletHistoryView(title: "Coins history", earnings: tokensHistoryItems)
//        }
//    }
    
    var paymentsTab: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Available payment methods")
                    .font(AppFont.everettMedium.size(20))
                    .foregroundColor(Colors.Primary.white)
                PaymentsAvaliableMethodsView(methods: availablePaymentMethods)
                Text("Available withdraw methods")
                    .font(AppFont.everettMedium.size(20))
                    .foregroundColor(Colors.Primary.white)
                PaymentsAvaliableMethodsView(methods: availablePaymentMethods)
                ProfileWalletHistoryView(title: "Transaction history", earnings: transactionHistory)
                Spacer()
            }
        } 
    }
    

}

struct PaymentMethodItem: Hashable {
    let imageName: String
    let methodName: String
}

struct PaymentsAvaliableMethodsView: View {
    
    let methods: [PaymentMethodItem]
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(methods, id: \.methodName) { method in
                HStack {
                    Image(method.imageName)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .cornerRadius(16)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 1)
                                .fill(Colors.Primary.blue)
                                .frame(width: 40, height: 40)
                        }
                        .background {
                            Circle()
                                .fill(Colors.Opacity.b)
                                .frame(width: 40, height: 40)
                        }
                    Spacer().frame(width: 14)
                    Text(method.methodName)
                        .font(AppFont.everettMedium.size(17))
                    Spacer()
                }
                .padding(.all, 5)
            }
            Divider()
            ButtonView(title: "Add new method") {
                withAnimation {
                    
                }
            }
        }
        .padding(.all, 16)
        .background(Colors.Secondary.highlightBlack)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .fill(Colors.Opacity.line)
        }
        .cornerRadius(16)
    }
}

struct TokensWalletBadgeView: View {
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Balance")
                    .font(AppFont.everettMedium.size(13))
                    .foregroundColor(Colors.Secondary.copyText)
                Text("500")
                    .font(AppFont.everettMedium.size(24))
                    .foregroundColor(Colors.Primary.white)
            }
            Spacer()
            Button {
                //
            } label: {
                Text("Purchase tokens")
                    .font(AppFont.everettMedium.size(17))
                    .foregroundColor(Colors.Primary.white)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(Colors.Opacity.b)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .fill(Colors.Primary.blue)
            }

        }
        .padding(.all, 16)
        .background(Colors.Secondary.highlightBlack)
        .cornerRadius(16)
    }
}

struct EarningsWalletBadgeView: View {
    
    var body: some View {
        VStack() {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Balance")
                        .font(AppFont.everettMedium.size(13))
                        .foregroundColor(Colors.Secondary.copyText)
                    Text("$635.00")
                        .font(AppFont.everettMedium.size(24))
                        .foregroundColor(Colors.Primary.white)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text("Available withdraw")
                        .font(AppFont.everettMedium.size(11))
                        .foregroundColor(Colors.Secondary.copyText)
                    Text("$400.90")
                        .font(AppFont.everettMedium.size(15))
                        .foregroundColor(Colors.Primary.white)
                }
            }
            Spacer().frame(height: 20)
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Pending amount")
                        .font(AppFont.everettMedium.size(11))
                        .foregroundColor(Colors.Secondary.copyText)
                    Text("$100.00")
                        .font(AppFont.everettMedium.size(15))
                        .foregroundColor(Colors.Primary.white)
                }
                Spacer()
                Text("56% completed")
                    .frame(height: 2)
                    .font(AppFont.everettRegular.size(11))
                    .foregroundColor(Colors.Secondary.copyText)
            }
            Spacer().frame(height: 1)
            ProgressView("", value: 0.7, total: 1)
                .tint(Colors.Primary.purpleA)
                .progressViewStyle(.linear)
        }
        .padding(.all, 16)
        .background(Colors.Secondary.highlightBlack)
        .cornerRadius(16)
    }
}

struct ProfileHistoryItem {
    let name: String
    let date: String
    let imageName: String
    let amount: String
}

struct ProfileWalletHistoryView: View {
    
    let title: String
    let earnings: [ProfileHistoryItem]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(AppFont.everettMedium.size(20))
                .foregroundColor(Colors.Primary.white)
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(earnings, id: \.date) { earning in
                        ProfileEarningHistoryItemView(earningHistory: earning)
                    }
                    Spacer()
                }
                .padding(.all, 5)
            }
        }
    }
}


struct ProfileEarningHistoryItemView: View {
    
    let earningHistory: ProfileHistoryItem
    
    var body: some View {
        HStack(alignment: .center) {
            Image(earningHistory.imageName)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(20)
            Spacer().frame(width: 14)
            VStack(alignment: .leading) {
                Text(earningHistory.name)
                    .font(AppFont.everettMedium.size(17))
                    .foregroundColor(Colors.Primary.white)
                Text(earningHistory.date)
                    .font(AppFont.everettRegular.size(13))
                    .foregroundColor(Colors.Secondary.copyText)
            }
            Spacer()
            Text(earningHistory.amount)
                .font(AppFont.everettMedium.size(15))
                .foregroundColor(Colors.Primary.white)
        }
        .padding(.all, 16)
        .background(Colors.Secondary.highlightBlack)
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 1)
                .fill(Colors.Opacity.line)
        }
        
    }
}
