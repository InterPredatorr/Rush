//
//  HeaderView.swift
//  Rush
//
//  Created by aziz on 2023-08-02.
//

import SwiftUI

struct HeaderView<Content>: View where Content: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    let isTabView: Bool
    var title: String?
    let titleOffset: CGFloat
    let contentView: Content
    var backButtonTapped: (() -> Void)?
    
    init(title: String? = nil, titleOffset: CGFloat = 0, isTabView: Bool = false, content: () -> Content, backButtonTapped: (() -> Void)? = nil) {
        self.title = title
        self.titleOffset = titleOffset
        self.isTabView = isTabView
        self.contentView = content()
        self.backButtonTapped = backButtonTapped
    }
    
    init(title: String? = nil, titleOffset: CGFloat = 0, isTabView: Bool = false, backButtonTapped: (() -> Void)? = nil) where Content == EmptyView {
        self.title = title
        self.titleOffset = titleOffset
        self.isTabView = isTabView
        self.contentView = EmptyView()
        self.backButtonTapped = backButtonTapped
    }
    
    var body: some View {
        HStack {
            Spacer()
            if let title {
                Text(title)
                    .foregroundColor(Colors.Primary.white)
                    .font(.system(size: 17, weight: .medium))
                    .offset(x: titleOffset)
            } else {
                contentView
            }
            Spacer()
        }
        .overlay(
            HStack {
                if !isTabView {
                    BackButtonView {
                        if backButtonTapped != nil {
                            backButtonTapped?()
                            return
                        }
                        coordinator.pop()
                    }
                }
                Spacer()
                if let _ = title {
                    contentView
                }
            }
        )
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Search", isTabView: false)
            .environmentObject(Coordinator())
            .previewLayout(.sizeThatFits)
    }
}
