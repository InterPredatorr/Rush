//
//  Colors.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

struct Colors {
    
    struct Gradients {
        static let onboardingGradient = Gradient(colors: [Color("Onboarding1"),
                                                          Color("Onboarding2"),
                                                          Color("Onboarding3")])
        static let loginGradient = Gradient(colors: [Color("Login1"),
                                                     Color("Login2")])
        static let journeyGradient = Gradient(colors: [Color("Journey1"),
                                                       Color("Journey2")])
        static let gameGridGradient = Gradient(colors: [Color("Game1"),
                                                        Color("Game1").opacity(0)])
        static let buyCoinsGradient = Gradient(colors: [Color("BuyCoins1"),
                                                        Color("BuyCoins2"),
                                                        Color("BuyCoins3")])
        static let withdrawGradient = Gradient(colors: [Color("withdraw1"),
                                                        Color("withdraw2"),
                                                        Color("withdraw3")])
    }
    
    struct Primary {
        static let white = Color("primaryWhite")
        static let black = Color("primaryBlack")
        static let blue = Color("primaryBlue")
        static let purpleA = Color("PurpleA")
        static let purpleB = Color("PurpleB")
    }
    
    struct Secondary {
        static let copyText = Color("secondaryCopyText")
        static let highlightBlack = Color("secondaryHighlightBlack")
    }
    
    struct Opacity {
        static let line = Color("opacityLine")
        static let bg = Color("BG")
        static let b = Color("OpacityB")
        static let a = Color("OpacityA")
    }
}
