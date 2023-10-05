//
//  String + Extensions.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import Foundation


extension String {
    var isValidPassword: Bool {
        guard self.count >= 6 else { return false }
        
        let specialCharacterSet = CharacterSet(charactersIn: "*!^$@")
        let lowercaseLetterCharacterSet = CharacterSet.lowercaseLetters
        let uppercaseLetterCharacterSet = CharacterSet.uppercaseLetters
        
        var hasSpecialCharacter = false
        var hasLowercaseLetter = false
        var hasUppercaseLetter = false
        
        for char in self.unicodeScalars {
            if specialCharacterSet.contains(char) {
                hasSpecialCharacter = true
            } else if lowercaseLetterCharacterSet.contains(char) {
                hasLowercaseLetter = true
            } else if uppercaseLetterCharacterSet.contains(char) {
                hasUppercaseLetter = true
            }
            if hasSpecialCharacter && hasLowercaseLetter && hasUppercaseLetter {
                break
            }
        }
        return hasSpecialCharacter && hasLowercaseLetter && hasUppercaseLetter
    }
    
    var isValidEmail: Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
