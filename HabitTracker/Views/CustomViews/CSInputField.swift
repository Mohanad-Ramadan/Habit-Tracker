//
//  CSInputField.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//

import SwiftUI

struct CSInputField: View {
    var isSecureField: Bool
    @State var fieldTitle: String
    @State var placeHolder: String
    @Binding var input: String
    @State var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(spacing: 5) {
            Text(fieldTitle)
                .font(.subheadline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black.opacity(0.7))
                .padding(.leading, 10)
            if isSecureField {
                SecureField(placeHolder, text: $input)
                    .padding()
                    .background(Color(.systemGray6))
                    .frame(height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .autocorrectionDisabled()
                    .keyboardType(.default)
            } else {
                TextField(placeHolder, text: $input)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .frame(height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .autocorrectionDisabled()
                    .keyboardType(keyboardType)
            }
        }
        .padding(.bottom, 15)
    }
}

#Preview {
    CSInputField(isSecureField: false, fieldTitle: "Email Address", placeHolder: "Place Holder", input: .constant("Hi"))
}
