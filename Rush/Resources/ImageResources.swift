//
//  ImageResources.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import Foundation

struct ImageResources {
    static let eye = "eye"
    static let eyeSlash = "eye.slash"
    static let appMain = "OnboardingImage"
    static let forgotPasswordBlue = "ForgotPasswordBlue"
    static let forgotPasswordPurple = "ForgotPasswordPurple"
    static let forgotPasswordEmail = "ForgotPasswordEmail"
    static let backButton = "chevron.left"
    static let nextButton = "chevron.right"
    static let search = "search"
    static let referralCoin = "ReferralCoin"
    static let arrowRight = "arrowRight"
    static let journeyMain = "JourneyMain"
    static let IconSearch = "magnifyingglass"
    static let buyCoins = "BuyCoins"
    static let fifa = "fifa"
    
    static func tabImage(at index: Int) -> String {
            return "TabImage\(index)"
    }
}

