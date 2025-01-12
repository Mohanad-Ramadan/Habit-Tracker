//
//  CSInputField.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//

import SwiftUI

enum TextFieldHolder: String {
    case email = "example@gmail.com"
    case password = "enter a password"
    case name = "ex: Harry Potter"
}

struct CSInputField: View {
    
    var isSecureField: Bool
    @State var fieldTitle: String
    @State var placeHolder: TextFieldHolder
    @Binding var input: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(fieldTitle)
                .font(.subheadline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black.opacity(0.7))
                .padding(.leading, 10)
            if isSecureField {
                SecureField(placeHolder.rawValue, text: $input)
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .autocorrectionDisabled()
            } else {
                TextField(placeHolder.rawValue, text: $input)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .autocorrectionDisabled()
            }
        }
        .padding(.bottom, 15)
    }
}

#Preview {
    CSInputField(isSecureField: false, fieldTitle: "Email Address", placeHolder: .email, input: .constant("Hi"))
}
