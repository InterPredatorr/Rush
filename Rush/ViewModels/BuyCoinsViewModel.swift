//
//  BuyCoinsViewModel.swift
//  Rush
//
//  Created by Aziz on 30.07.23.
//

import Foundation

class BuyCoinsViewModel: ObservableObject {
    
    var config = SettingsManager.shared.buyCoins
    @Published var userCoinsCount = 0
    
    var tokensCountText: String {
        return "\(userCoinsCount) tokens"
    }
    
}
