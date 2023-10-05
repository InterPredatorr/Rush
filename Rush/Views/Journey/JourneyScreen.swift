//
//  JourneyScreen.swift
//  Rush
//
//  Created by Aziz on 28.07.23.
//

import SwiftUI

struct JourneyScreen: View {
    
    @ObservedObject var viewModel: JourneyViewModel
    
    var body: some View {
        switch viewModel.currentView {
        case .devices, .games:
            JourneyView(viewModel: viewModel)
        case .psnUsername, .xboxUsername:
            JourneyUsernameView(currentView: $viewModel.currentView,
                                itemConfig: viewModel.selectedDeviceConfig,
                                text: $viewModel.usernameText)
        }
    }
    
}

