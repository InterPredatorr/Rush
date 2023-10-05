//
//  Fonts.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

private let everettRegular = "TWKEverett-Regular"

enum AppFont: String {
    case everettRegular = "TWKEverett-Regular"
    case everettMedium = "TWKEverett-Medium"
    case spaceMonoRegular = "SpaceMono-Regular"
    case spaceMonoBoldItalic = "SpaceMono-BoldItalic"
    case spaceMonoItalic = "SpaceMono-Italic"
    case spaceMonoBold = "SpaceMono-Bold"

    func size(_ size: CGFloat) -> Font {
        if let font = UIFont(name: rawValue, size: size) {
            return Font(font)
        }
        fatalError("Font '\(rawValue)' does not exist.")
    }
}
