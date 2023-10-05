//
//  ProfileEditView.swift
//  Rush
//
//  Created by Aziz on 07.08.23.
//

import SwiftUI

struct ProfileEditView: View {
    
    @State var input: String = ""
    @State var fields: [TextFieldConfig] = [
        .init(title: "Username", placeholderText: "beastIncarnate392"),
        .init(title: "First name", placeholderText: "Beast"),
                                     .init(title: "Last name", placeholderText: "Incarnate"),
                                     .init(title: "Age (optional)", placeholderText: "22"),
                                     .init(title: "Email", placeholderText: "beasta623@gmail.com"),
                                     .init(title: "Change Password", placeholderText: "********")]
    
    var body: some View {
        VStack {
            profileImage
            ScrollView {
                Spacer(minLength: 30)
                VStack(alignment: .leading) {
                    ForEach(fields, id: \.self) { field in
                        Text(field.title)
                            .font(AppFont.everettMedium.size(17))
                            .foregroundColor(Colors.Primary.white)
                        Spacer().frame(height: 7)
                        TextFieldView(config: field, text: $input,
                                      isSecure: field.placeholderText.contains("*"), isHideButtonNeeded: false)
                        Spacer().frame(height: 20)
                    }
                    Text("Very weak")
                }
            }
        }
        .padding(.vertical, 30)
    }
}


private extension ProfileEditView {
    
    var profileImage: some View {
        Image("wong")
            .resizable()
            .frame(width: 100, height: 100)
            .cornerRadius(50)
            .overlay {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(lineWidth: 2)
                    .fill(Colors.Opacity.line)
                Button {
                    // show gallery
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 30, height: 30)
                        .background(Colors.Opacity.b)
                        .cornerRadius(15)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 1)
                                .fill(Colors.Primary.blue)
                        }
                }
                .position(x: 85, y: 85)
            }
    }
}


struct ProfileTabsView: View {
    
    @Binding var types: [ProfileTabItem]
    
    var body: some View {
        HStack {
            ForEach(types) { type in
                Button {
                    types = types.map { t in
                        var tmp = t
                        tmp.isSelected = t.id == type.id
                        return tmp
                    }
                } label: {
                    HStack {
                        Text(type.title)
                            .font(AppFont.everettMedium.size(17))
                            .scaledToFill()
                            .foregroundColor(type.isSelected ? Colors.Primary.white : Colors.Secondary.copyText)
                            .padding(.horizontal, 16)
                    }
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .background(type.isSelected ? Colors.Primary.blue : Colors.Secondary.highlightBlack)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .fill(type.isSelected ? Colors.Primary.blue : Colors.Opacity.line)
                    }
                    .cornerRadius(10)
                }
            }
        }
    }
}
