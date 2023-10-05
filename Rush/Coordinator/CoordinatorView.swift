//
//  CoordinatorView.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

struct CoordinatorView: View {
        
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .general)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                        .navigationBarBackButtonHidden(true)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
                    coordinator.build(fullScreenCover: fullScreenCover)
                        .navigationBarBackButtonHidden(true)
                        
                }
                
        }
        .sheet(item: $coordinator.sheet, onDismiss: {
            coordinator.dismiss()
        }, content: { sheet in
            coordinator.build(sheet: sheet)
            .presentationDetents([coordinator.sheetPresentationDetent() ?? .large])
            .navigationBarBackButtonHidden(true)
        })
        .environmentObject(coordinator)
    }
}
