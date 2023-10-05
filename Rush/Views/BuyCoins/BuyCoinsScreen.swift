//
//  BuyCoinsScreen.swift
//  Rush
//
//  Created by Aziz on 30.07.23.
//

import SwiftUI

struct BuyCoinsScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel: BuyCoinsViewModel
    let isSheet: Bool

    var body: some View {
        VStack(alignment: .leading) {
            BuyCoinsTopView(config: viewModel.config, isSheet: isSheet) {
                nextAction()
            }
            BuyCoinsView(viewModel: viewModel) {
                nextAction()
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    func nextAction() {
        if isSheet {
            coordinator.dismissFullScreenCover()
            coordinator.present(.requestToPlay(true), size: .medium)
            return
        }
        coordinator.push(.general)
    }
}
