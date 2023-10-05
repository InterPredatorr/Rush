//
//  BuyCoinsView.swift
//  Rush
//
//  Created by Aziz on 30.07.23.
//

import SwiftUI

struct BuyCoinsView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel: BuyCoinsViewModel
    let buttonTapped: () -> Void
    private let columns = [GridItem(.flexible()),
                           GridItem(.flexible())]
    
    var body: some View {
        VStack {
            BuyCoinsTokensCountBadgeView(viewModel: viewModel)
            Spacer().frame(height: 20)
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(viewModel.config.options, id: \.self) { option in
                    BuyCoinsOptionView(option: option) {
                        buttonTapped()
                    }
                }
            }
        }
    }
}

struct BuyCoinsOptionView: View {
    
    let option: BuyCoinsConfig.BuyCoinsOption
    let buttonTapped: () -> Void
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                Spacer().frame(height: 30)
                VStack {
                    Spacer().frame(height: 45)
                    Text(option.title)
                        .font(AppFont.everettMedium.size(13))
                        .foregroundColor(Colors.Primary.white)
                        .frame(maxWidth: .infinity)
                    Spacer().frame(height: 6)
                    Text(String(option.count) + " tokens")
                        .font(AppFont.everettMedium.size(24))
                        .foregroundColor(Colors.Primary.white)
                    Spacer().frame(height: 16)
                    Button {
                        buttonTapped()
                    } label: {
                        Text("$\(option.cost.removeZerosFromEnd())")
                            .font(AppFont.everettMedium.size(17))
                            .foregroundColor(Colors.Primary.white)
                            .frame(maxWidth: .infinity)
                            .padding(.all, 10)
                    }
                    .background(Colors.Primary.purpleA.cornerRadius(8))
                    .padding(.horizontal, 25)
                    Spacer().frame(height: 20)
                    
                }
                .background(Colors.Secondary.highlightBlack)
                .cornerRadius(16)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(lineWidth: 1)
                        .fill(Colors.Opacity.line)
                }
            }
            VStack {
                HStack {
                    Spacer()
                    Image(ImageResources.buyCoins)
                        .resizable()
                        .frame(width: 60, height: 60)
                    Spacer()
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
}
