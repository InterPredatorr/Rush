//
//  JourneyView.swift
//  Rush
//
//  Created by Aziz on 29.07.23.
//

import SwiftUI

struct JourneyView: View {
    
    @ObservedObject var viewModel: JourneyViewModel
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    var body: some View {
        VStack {
            JourneyTopView(title: viewModel.title)
            SearchField(searchText: $viewModel.searchText)
            contentView
            buttons
        }
        .padding(.horizontal, 16)
        .background { background }
    }
    
    var contentView: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                switch viewModel.currentView {
                case .devices:
                    JourneyDevicesView(viewModel: viewModel)
                case .games:
                    JourneyGamesView(viewModel: viewModel)
                default:
                    EmptyView()
                }
                Spacer()
            }
            .padding(.all, 2)
        }
        .scrollIndicators(.hidden)
    }
    
    var background: some View {
        VStack {
            Image(ImageResources.journeyMain)
                .resizable()
                .frame(height: UIScreen.main.bounds.height * 0.4)
                .mask {
                    LinearGradient(gradient: Colors.Gradients.journeyGradient,
                                   startPoint: .bottom,
                                   endPoint: .top)
                }
            Spacer()
        }
        .ignoresSafeArea()
    }
    
    var buttons: some View {
        VStack {
            ButtonView(title: "Continue") {
                withAnimation {
                    viewModel.currentView = viewModel.currentView == .devices ? .games : .psnUsername
                }
            }
            .disabled(viewModel.continueButtonDisabled)
            .opacity(viewModel.buttonOpacity)
            if viewModel.currentView == .games {
                Spacer().frame(height: 16)
                ButtonView(title: "Can’t find the game", isPrimaryButton: false) {
                    withAnimation {
                        // TODO:
                    }
                }
            }
            Spacer().frame(height: 30)
        }
    }
}
