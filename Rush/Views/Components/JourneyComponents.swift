//
//  JourneyComponents.swift
//  Rush
//
//  Created by Aziz on 28.07.23.
//

import SwiftUI

struct JourneyDeviceItemView: View {
    
    var item: DevicesConfig.Device
    
    let itemSize = (UIScreen.main.bounds.width - 56) / 3
    
    var body: some View {
        ZStack(alignment: .center) {
            if item.isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Colors.Primary.blue)
                    .frame(width: 24)
                    .aspectRatio(1, contentMode: .fit)
                    .position(x: itemSize - 18,
                              y: 18)
            }
            Image(item.imageName)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .padding(.all, 24)
                .position(x: itemSize / 2,
                          y: itemSize / 2)
        }
        .aspectRatio(1, contentMode: .fit)
        .background(RoundedRectangle(cornerRadius: 16).fill(Colors.Secondary.highlightBlack)
            .overlay(RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 0.5)
                .foregroundColor(item.isSelected ? Colors.Primary.blue : Colors.Opacity.line)))
    }
}

struct JourneyGameItemView: View {
    
    var item: GamesConfig.Game
    
    let itemSize = (UIScreen.main.bounds.width - 56) / 3
    
    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                Image(item.imageName)
                    .resizable()
                if item.isSelected {
                    LinearGradient(gradient: Colors.Gradients.gameGridGradient,
                                   startPoint: .topTrailing,
                                   endPoint: .bottom)
                    .cornerRadius(16)
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Colors.Primary.white)
                        .frame(width: 24)
                        .aspectRatio(1, contentMode: .fit)
                        .position(x: itemSize - 18,
                                  y: 18)
                }
            }
            .aspectRatio(1, contentMode: .fit)
            Spacer().frame(height: 10)
            Text(item.gameName)
                .font(AppFont.everettMedium.size(15))
                .foregroundColor(Colors.Primary.white)
        }
        .background(RoundedRectangle(cornerRadius: 16).fill(.clear))
    }
}

struct JourneyTopView: View {
    
    let title: String
    
    var body: some View {
        Spacer().frame(height: 30)
        HStack {
            Text(title)
                .font(AppFont.everettMedium.size(24))
                .foregroundColor(Colors.Primary.white)
            Spacer()
        }
        .padding(.horizontal, 16)
        Spacer().frame(height: 24)
    }
}


struct JourneyDevicesView: View {
    
    @ObservedObject var viewModel: JourneyViewModel
    
    var body: some View {
        ForEach(viewModel.deviceSearchResults, id: \.self) { item in
            JourneyDeviceItemView(item: item)
                .onTapGesture {
                    viewModel.updateSelectedDevice(with: item.deviceType)
                }
        }
    }
}

struct JourneyGamesView: View {
    
    @ObservedObject var viewModel: JourneyViewModel
    
    var body: some View {
        ForEach(viewModel.gameSearchResults, id: \.self) { item in
            JourneyGameItemView(item: item)
                .onTapGesture {
                    withAnimation {
                        viewModel.updateSelectedGame(with: item.gameName)
                    }
                }
        }
    }
}
