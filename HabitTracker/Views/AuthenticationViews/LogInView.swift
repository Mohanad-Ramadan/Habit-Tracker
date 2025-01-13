//
//  LogInView.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//


import SwiftUI

struct LogInView: View {
    @EnvironmentObject private var logeInViewModel: AuthViewModel
    @Environment(\.dismiss) var dismissScreen
    @Binding var showSignInView: Bool
    @FocusState private var fieldInFocus: FocusedField?
    
    var body: some View {
        VStack(spacing: 0) {
            //MARK: Title
            VStack(alignment: .listRowSeparatorLeading, spacing: 5) {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Welcome Back!")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 30)
            
            //MARK: - Email Text Feild
            CSInputField(
                shouldSanitizeDots: false,
                isSecureField: false,
                fieldTitle: "Email Address",
                placeHolder: "example@gmail.com",
                input: $logeInViewModel.email,
                keyboardType: .emailAddress
            )
            .onSubmit { fieldInFocus = .password }

            //MARK: - Password Feild
            CSInputField(
                isSecureField: true,
                fieldTitle: "Password",
                placeHolder: "enter a password",
                input: $logeInViewModel.password
            )
            .focused($fieldInFocus, equals: .password)
            
            //MARK: - logeIn Button
            Button {
                authecticateUser()
            } label: {
                Text("Login")
                    .textCase(.uppercase)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange.gradient)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.vertical, 10)
            
            //MARK: - SignUp Button
            HStack {
                Text("Don’t have an account?")
                    .foregroundColor(.black.opacity(0.6))
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Button {
                    logeInViewModel.currentSignView = .signUpView
                } label: {
                    Text("Sign up")
                        .foregroundColor(.blue)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }
            
        }
        .padding()
        .padding(.vertical, 15)
    }
    
    func authecticateUser() {
        Task {
            do {
                try await logeInViewModel.logIn()
                showSignInView = false
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // field focus enum
    enum FocusedField: Hashable {
        case email, password
    }
}



#Preview {
    NavigationStack {
        LogInView(showSignInView: .constant(true))
    }
    
}
