//
//  RushApp.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

@main
struct RushApp: App {
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .preferredColorScheme(.dark)
        }
    }
}
