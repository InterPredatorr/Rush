//
//  ChatScreen.swift
//  Rush
//
//  Created by aziz on 2023-07-29.
//

import SwiftUI


struct Message {
    let fromMe: Bool
    let content: String
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
            .border(Color.red)
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
struct ChatScreen: View {
    
    @State private var message = ""
    
    @State private var messages = [
        Message(fromMe: true, content: "Hi\nHow are you?"),
        Message(fromMe: true, content: "Hellooo?"),
        Message(fromMe: false, content: "Hey, yes, what's up?"),
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Colors.Primary.black
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                header
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(Array(messages.enumerated()), id: \.offset) { index, message in
                            getViewFor(message)
                            if (index == messages.count-1) {
                                Spacer()
                                    .frame(height: 40)
                            }
                        }
                    }
                }
            }
            .padding()
            
            VStack {
                bottomBar
            }
            .background(Colors.Secondary.highlightBlack)
        }
        .navigationBarBackButtonHidden()
    }
}

private extension ChatScreen {
    var header: some View {
        HeaderView() {
            HStack(spacing: 16) {
                Image("soni")
                VStack(alignment: .leading) {
                    Text("Andrade Gold")
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 20, weight: .medium))
                    
                    Text("Online")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 15, weight: .medium))
                }
            }
            .offset(x: -20)
            
        }
    }
    
    var bottomBar: some View {
        HStack {
            Button(action: {}) {
                Text("+")
                    .font(.system(size: 45))
                    .foregroundColor(Colors.Primary.blue)
            }
            RoundedView(color: Colors.Primary.black, cornerRadius: 40) {
                HStack {
                    TextField("", text: $message, prompt: Text("Type a message....").foregroundColor(.gray))
                        .foregroundColor(Colors.Primary.white)
                        .font(.system(size: 20, weight: .medium))
                        .padding(.horizontal)
                        .onSubmit {
                            messages.append(Message(fromMe: true, content: message))
                            message = ""
                        }
                    Button(action: {}) {Image("smiley")}
                }
            }
        }
        .padding()
    }
    
    func getViewFor(_ message: Message) -> some View {
        var corners: UIRectCorner = [.topLeft, .bottomLeft, .topRight]
        if (!message.fromMe) {
            corners = [.topLeft, .topRight, .bottomRight]
        }
        return
        HStack(alignment: .bottom) {
            if (message.fromMe) {
                Spacer()
            } else {
                Image("soni")
            }
            
            Text(message.content)
                .foregroundColor(Colors.Primary.white)
                .font(.system(size: 20, weight: .medium))
                .multilineTextAlignment(message.fromMe ? .trailing : .leading)
                .padding()
                .background(
                    RoundedCorner(radius: 16, corners: corners)
                        .fill(message.fromMe ? Colors.Secondary.highlightBlack : Colors.Primary.blue.opacity(0.3))
                        .overlay(
                            RoundedCorner(radius: 16, corners: corners)
                                .stroke(message.fromMe ? Color.clear : Colors.Primary.blue, lineWidth: 2)
                        )
                )
            
            if (!message.fromMe) {
                Spacer()
            }
        }
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen()
    }
}
