//
//  Double + Extensions.swift
//  Rush
//
//  Created by Aziz on 30.07.23.
//

import Foundation

extension Double {
    
    func removeZerosFromEnd() -> String {
            let formatter = NumberFormatter()
            let number = NSNumber(value: self)
            formatter.minimumFractionDigits = 2
            return String(formatter.string(from: number) ?? "")
        }
}
