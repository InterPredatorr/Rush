//
//  ReusableViews.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI

struct ButtonView: View {
    
    let title: String
    var height: CGFloat? = nil
    var font: Font? = nil
    var cornerRadius: CGFloat? = nil
    var backgroundColor: Color? = nil
    var borderColor: Color? = nil
    var textColor: Color? = nil
    var isPrimaryButton = true
    var isProgressViewEnabled: Bool = false
    let buttonTapped: () -> Void
    
    var body: some View {
        Button {
            buttonTapped()
        } label: {
            HStack(spacing: 8) {
                Spacer()
                Text(title)
                    .font(font ?? AppFont.everettMedium.size(17))
                    .frame(height: height ?? 52)
                if isProgressViewEnabled {
                    ProgressView()
                        .tint(textColor ?? Colors.Primary.white)
                        .progressViewStyle(.circular)
                }
                Spacer()
            }
            .foregroundColor(textColor ?? Colors.Primary.white)
            .background(backgroundColor ?? (isPrimaryButton ? Colors.Primary.purpleA : Colors.Secondary.highlightBlack))
            .frame(maxWidth: .infinity)
            .cornerRadius(cornerRadius ?? 12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: isPrimaryButton ? 0 : 1)
                    .fill(borderColor ?? Colors.Opacity.line)
            }
        }
    }
}

struct TextFieldView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @FocusState private var focused: Bool
    let config: TextFieldConfig
    @Binding var text: String
    var isSecure: Bool
    var cornerRadius: CGFloat? = nil
    var background: Color? = nil
    var keyboardType: UIKit.UIKeyboardType = .default
    
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isHidden {
                SecureField(text: $text) {
                    Text(config.placeholderText)
                        .foregroundColor(Colors.Secondary.copyText)
                        .font(AppFont.everettRegular.size(15))
                }
                .padding(.leading)
                .frame(height: 48)
                .textContentType(.password)
                .textFieldStyle(PlainTextFieldStyle())
                .background(background ?? Colors.Secondary.highlightBlack)
                .foregroundColor(Colors.Primary.white)
                .cornerRadius(cornerRadius ?? 10)
                .keyboardType(keyboardType)
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius ?? 10)
                        .stroke(lineWidth: 1)
                        .fill(Colors.Opacity.line)
                }
            } else {
                TextField(text: $text) {
                    Text(config.placeholderText)
                        .foregroundColor(Colors.Secondary.copyText)
                        .font(AppFont.everettRegular.size(15))
                }
                .padding(.leading)
                .frame(height: 48)
                .textContentType(.emailAddress)
                .textFieldStyle(PlainTextFieldStyle())
                .background(background ?? Colors.Secondary.highlightBlack)
                .foregroundColor(Colors.Primary.white)
                .cornerRadius(cornerRadius ?? 10)
                .focused($focused)
                .keyboardType(keyboardType)
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius ?? 10)
                        .stroke(lineWidth: 1)
                        .fill(Colors.Opacity.line)
                }
            }
            if isSecure && isHideButtonNeeded {
                Button {
                    isHidden.toggle()
                } label: {
                    Image(systemName: isHidden ? ImageResources.eye : ImageResources.eyeSlash)
                        .foregroundColor(Colors.Secondary.copyText)
                        .padding()
                }
            }
        }
        .onAppear {
            isHidden = isSecure
        }
        .onChange(of: coordinator.fullScreenCover) { focused = $0 == nil }
    }
}


struct SearchField: View {
    
    @Binding var searchText: String
    var placeholderText: String = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.gray)
            TextField("", text: $searchText)
                .placeholder(when: searchText.isEmpty, placeholder: {
                    Text(!placeholderText.isEmpty ? placeholderText : "Search").foregroundColor(Colors.Secondary.copyText)
                })
                .foregroundColor(Colors.Secondary.copyText)
                .font(AppFont.everettRegular.size(16))
        }
        .frame(height: 48)
        .padding(.horizontal, 16)
        .background(Colors.Secondary.highlightBlack)
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor( Colors.Opacity.line)
        }
    }
}

struct BackButtonView: View {
    
    let buttonTapped: () -> Void
    private let buttonHeight = 40.0
    
    var body: some View {
        HStack {
            Button {
                buttonTapped()
            } label: {
                Image(systemName: ImageResources.backButton)
                    .frame(width: buttonHeight, height: buttonHeight)
                    .foregroundColor(Colors.Primary.white)
                    .background(Colors.Secondary.highlightBlack)
                    .cornerRadius(buttonHeight / 2)
            }
            Spacer()
        }
        .frame(height: buttonHeight)
        .frame(maxWidth: .infinity)
    }
}

struct PlayerView: View {
    
    @Binding var player: Player
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: player.imageUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 36, height: 36)
            .cornerRadius(18)
            Spacer().frame(width: 12)
            Text(player.name)
                .font(AppFont.everettMedium.size(20))
                .foregroundColor(Colors.Primary.white)
            Spacer()
            Button {
                player.isFollowing = true
            } label: {
                Text("Follow")
                    .font(AppFont.everettMedium.size(13))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: player.isFollowing ? 1 : 0)
                            .foregroundColor(Colors.Opacity.line)
                    }
            }
            .foregroundColor(Colors.Primary.white)
            .background(player.isFollowing ? Colors.Secondary.highlightBlack : Colors.Primary.blue)
            .cornerRadius(8)
        }
        .frame(height: 52)
        .frame(maxWidth: .infinity)
    }
}

struct TitleViewWithSkip: View {
    
    let title: String
    let isSheet: Bool
    let skipButtonIsEnabled: Bool
    let buttonTapped: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(AppFont.everettMedium.size(24))
                .foregroundColor(Colors.Primary.white)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            Spacer()
            if skipButtonIsEnabled {
                Button {
                    buttonTapped()
                } label: {
                    Text(isSheet ? "Done" : "Skip")
                        .frame(width: 75, height: 35)
                        .font(AppFont.everettMedium.size(17))
                        .foregroundColor(isSheet ? Colors.Primary.white : Colors.Primary.purpleA)
                }
            }
        }
    }
}

struct ExpandableText: View {
    let text: String
    let lineLimit: Int
    
    @State private var isExpanded: Bool = false
    @State private var isTruncated: Bool? = nil
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Text(text)
                .lineLimit(isExpanded ? nil : lineLimit)
                .background(calculateTruncation(text: text))
            
            if isTruncated == true {
                button
            }
        }
        .multilineTextAlignment(.leading)
        .onChange(of: text) { _ in withAnimation { isTruncated = nil } }
    }
    
    func calculateTruncation(text: String) -> some View {
        ViewThatFits(in: .vertical) {
            Text(text)
                .hidden()
                .onAppear {
                    guard isTruncated == nil else { return }
                    isTruncated = false
                }
            Color.clear
                .hidden()
                .onAppear {
                    guard isTruncated == nil else { return }
                    isTruncated = true
                }
        }
    }
    
    var button: some View {
        Button(isExpanded ? "Read less" : "Read more") {
            withAnimation {
                isExpanded.toggle()
            }
        }
        .foregroundColor(Colors.Primary.blue)
    }
}

struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .stroke(
                    Colors.Opacity.b,
                    lineWidth: 10
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Colors.Primary.blue,
                    style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
    }
}

struct SheetsDragIndicator: View {
    var body: some View {
        HStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 140, height: 5)
                .foregroundColor(Colors.Opacity.line)
        }
        .padding(.top, 12)
        .padding(.bottom, 24)
    }
}
