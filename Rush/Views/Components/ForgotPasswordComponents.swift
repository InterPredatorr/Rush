//
//  ForgotPasswordComponents.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import SwiftUI
import Combine

struct ForgotPasswordTopView: View {
    
    private let topSpacing = UIScreen.main.bounds.height / 20
    private let imageHeight = 70.0
    
    let imageName: String
    let title: String
    let description: String
    var email: String? = nil
    
    var body: some View {
        Spacer().frame(height: topSpacing)
        Image(imageName)
            .resizable()
            .frame(width: imageHeight, height: imageHeight)
        Spacer().frame(height: 24)
        Text(title)
            .font(AppFont.everettMedium.size(24))
            .foregroundColor(Colors.Primary.white)
        Spacer().frame(height: 8)
        Text(description)
            .multilineTextAlignment(.center)
            .font(AppFont.everettRegular.size(15))
            .foregroundColor(Colors.Secondary.copyText)
        if let email = email {
            Text(email)
                .multilineTextAlignment(.center)
                .font(AppFont.everettRegular.size(15))
                .foregroundColor(Colors.Primary.white)
        }
    }
}

struct OtpModifer: ViewModifier {
    
    @Binding var pin : String
    private let boxSize = UIScreen.main.bounds.width / 6
    var textLimt = 1
    
    func limitText(_ upper : Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }
    
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText(textLimt)}
            .frame(width: boxSize, height: boxSize)
            .foregroundColor(Colors.Opacity.bg)
            .tint(.clear)
            .font(AppFont.everettMedium.size(36))
            .background(Colors.Secondary.highlightBlack)
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(lineWidth: 2)
                    .foregroundColor(Colors.Opacity.line)
            )
    }
}

struct OtpFormFieldView: View {
    
    
    enum FocusPin: Int {
        case  pinOne, pinTwo, pinThree, pinFour
    }
    
    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    @Binding var pin: String
    
    var body: some View {
        HStack(spacing: 8) {
            TextField("", text: $pinOne)
                .modifier(OtpModifer(pin: $pinOne))
                .onChange(of:pinOne) { updateField(with: $0) }
                .focused($pinFocusState, equals: .pinOne)
            TextField("", text:  $pinTwo)
                .modifier(OtpModifer(pin: $pinTwo))
                .onChange(of: pinTwo) { updateField(with: $0) }
                .focused($pinFocusState, equals: .pinTwo)
            TextField("", text:$pinThree)
                .modifier(OtpModifer(pin: $pinThree))
                .onChange(of: pinThree) { updateField(with: $0) }
                .focused($pinFocusState, equals: .pinThree)
            TextField("", text:$pinFour)
                .modifier(OtpModifer(pin: $pinFour))
                .onChange(of: pinFour) { updateField(with: $0) }
                .focused($pinFocusState, equals: .pinFour)
        }
        .padding(.vertical)
    }
    
    func updateField(with newVal: String) {
        if newVal.isEmpty {
            _ = pin.popLast()
            guard pinFocusState != .pinOne else { return }
            pinFocusState = .init(rawValue: pinFocusState!.rawValue - 1)
        } else if newVal.count == 1 {
            if pin.count < 4 { pin += newVal }
            guard pinFocusState != .pinFour else { return }
            pinFocusState = .init(rawValue: pinFocusState!.rawValue + 1)
        }
    }
}

