//
//  BuyCoinsComponents.swift
//  Rush
//
//  Created by Aziz on 30.07.23.
//

import SwiftUI

struct BuyCoinsTopView: View {
    
    let config: BuyCoinsConfig
    let isSheet: Bool
    let buttonTapped: () -> Void
    
    var body: some View {
        Spacer().frame(height: 30)
        TitleViewWithSkip(title: config.title, isSheet: isSheet, skipButtonIsEnabled: true) {
            buttonTapped()
            
        }
        Spacer().frame(height: 12)
        HStack {
            Text(config.description)
                .font(AppFont.everettRegular.size(15))
                .foregroundColor(Colors.Secondary.copyText)
                .multilineTextAlignment(.leading)
                .lineLimit(4)
                .minimumScaleFactor(0.8)
            Spacer().frame(width: 70)
        }
        Spacer().frame(height: 70)
        Text(config.subtitle)
            .font(AppFont.everettRegular.size(15))
            .foregroundColor(Colors.Secondary.copyText)
        Spacer().frame(height: 16)
    }
}


struct BuyCoinsTokensCountBadgeView: View {
    
    @ObservedObject var viewModel: BuyCoinsViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text(viewModel.config.tokenBalanceTitle)
                .font(AppFont.everettMedium.size(13))
                .foregroundColor(Colors.Primary.white)
            Spacer()
            Text(viewModel.tokensCountText)
                .font(AppFont.everettMedium.size(28))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 90)
        .cornerRadius(12)
        .background {
            LinearGradient(gradient: Colors.Gradients.buyCoinsGradient,
                           startPoint: .top,
                           endPoint: .bottom)
            .cornerRadius(12)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 1)
                .fill(Colors.Opacity.line)
        }
    }
}
