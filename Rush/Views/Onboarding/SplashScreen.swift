//
//  SplashScreen.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

struct SplashScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    let items = SettingsManager.shared.splash.items
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedIndex) {
                ForEach(items, id: \.title) { item in
                    VStack {
                        Image(item.imageName)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .padding(.horizontal, 43)
                        Spacer().frame(height: 74)
                        Text(item.title)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Colors.Primary.white)
                            .font(AppFont.everettMedium.size(24))
                        Spacer().frame(height: 12)
                        Text(item.description)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Colors.Secondary.copyText)
                            .font(AppFont.everettRegular.size(15))
                    }
                    .tag(item.index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            SplashBottomBarView(pagesCount: items.count, selectedIndex: $selectedIndex)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 16)
        .background(Colors.Primary.black)
    }
}

struct SplashBottomBarView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    let pagesCount: Int
    @Binding var selectedIndex: Int
    private let buttonSize = 48.0
    
    var body: some View {
        HStack {
            Button {
                coordinator.dismissFullScreenCover()
            } label: {
                Text("Skip")
                    .foregroundColor(Colors.Primary.white)
                    .font(AppFont.everettMedium.size(17))
            }
            Spacer()
            SplashIndicesView(pagesCount: pagesCount, selectedIndex: $selectedIndex)
            Spacer()
            Button {
                if selectedIndex == pagesCount - 1 {
                    coordinator.dismissFullScreenCover()
                }
                withAnimation {
                    selectedIndex += 1
                }
            } label: {
                Image(systemName: ImageResources.nextButton)
                    .foregroundColor(Colors.Primary.white)
            }
            .frame(width: buttonSize, height: buttonSize)
            .background(Colors.Primary.blue)
            .cornerRadius(buttonSize / 2)
        }
        .frame(height: buttonSize)
        .frame(maxWidth: .infinity)
        .background(Colors.Primary.black)
    }
}

struct SplashIndicesView: View {
    
    let pagesCount: Int
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            ForEach(0..<pagesCount, id: \.self) { index in
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: selectedIndex == index ? 22 : 10, height: 4)
                    .foregroundColor(selectedIndex == index ? Colors.Primary.blue : Colors.Secondary.copyText)
            }
        }
    }
}


