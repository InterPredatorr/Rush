//
//  ProfileWithdrawPaymentView.swift
//  Rush
//
//  Created by Aziz on 09.08.23.
//

import SwiftUI

struct ProfileWithdrawPaymentView: View {
    
    @Binding var profileActionType: ProfileActionType
    @State var selectedMethod = "ApplePay"
    @State var withdrawAmountString = ""
    let withdrawMethods: [PaymentMethodItem] = [.init(imageName: "ApplePay", methodName: "Apple Pay"),
                                                .init(imageName: "PayPalPay", methodName: "PayPal"),
                                                .init(imageName: "GooglePay", methodName: "Google Pay")]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            VStack {
                Spacer().frame(height: 30)
                LinearGradient(gradient: Colors.Gradients.withdrawGradient,
                               startPoint: .top, endPoint: .bottom)
                .cornerRadius(16)
            }
            .frame(height: 145)
            .overlay {
                VStack(alignment: .center) {
                    Image("wong")
                        .frame(width: 64, height: 64)
                        .cornerRadius(32)
                        .overlay {
                            RoundedRectangle(cornerRadius: 32)
                                .stroke(lineWidth: 1)
                                .fill(Colors.Opacity.line)
                        }
                    Spacer().frame(height: 16)
                    Text("Available withdraw")
                        .font(AppFont.everettRegular.size(13))
                        .foregroundColor(Colors.Primary.white)
                    Spacer().frame(height: 4)
                    Text("$400.90")
                        .font(AppFont.everettMedium.size(24))
                        .foregroundColor(Colors.Primary.white)
                    Spacer()
                }
            }
            VStack(alignment: .leading) {
                Text("Enter amount")
                    .font(AppFont.everettMedium.size(17))
                    .foregroundColor(Colors.Primary.white)
                Spacer().frame(height: 10)
                TextFieldView(config: .init(title: "", placeholderText: ""),
                                  text: $withdrawAmountString,
                                  isSecure: false)
            }
            Text("Select withdrawal method")
                .font(AppFont.everettMedium.size(17))
                .foregroundColor(Colors.Primary.white)
            HStack {
                Group {
                    ForEach(withdrawMethods, id: \.self) { method in
                        VStack {
                            Image(method.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 84, height: 56)
                                
                            Text(method.methodName)
                        }
                        .padding(.horizontal, 11)
                        .padding(.vertical, 16)
                        .frame(height: 110)
                        .frame(maxWidth: .infinity)
                        .background(selectedMethod == method.imageName ? Colors.Primary.blue : Colors.Secondary.highlightBlack)
                        .cornerRadius(12)
                        .onTapGesture {
                            withAnimation {
                                selectedMethod = method.imageName
                            }
                        }
                    }
                }
            }
            Spacer()
            VStack(spacing: 16) {
                ButtonView(title: "Confirm withdraw", isPrimaryButton: true) {
                    withAnimation {
                        profileActionType = .wallet()
                    }
                }
                ButtonView(title: "Add new withdraw method", isPrimaryButton: false) {
                    withAnimation {
                        profileActionType = .wallet(.payments)
                    }
                }
            }
        }
        .padding(.top, 40)
    }
}
