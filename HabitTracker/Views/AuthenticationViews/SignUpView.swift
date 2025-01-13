//
//  SignUpView.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//

import SwiftUI


struct SignUpView: View {
    @EnvironmentObject private var logeInViewModel: AuthViewModel
    @Environment(\.dismiss) var dismissScreen
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            //MARK: Title
            VStack(alignment: .listRowSeparatorLeading, spacing: 5) {
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Hello! please enter your detials.")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 30)
            
            //MARK: - User Name
            CSInputField(
                isSecureField: false,
                fieldTitle: "Full Name",
                placeHolder: "ex: Harry Potter",
                input: $logeInViewModel.userName
            )
            
            
            //MARK: - Email Text Feild
            CSInputField(
                isSecureField: false,
                fieldTitle: "Email Address",
                placeHolder: "example@gmail.com",
                input: $logeInViewModel.email,
                keyboardType: .emailAddress
            )
            
            
            //MARK: - Password Feild
            CSInputField(
                isSecureField: true,
                fieldTitle: "Password",
                placeHolder: "enter a password",
                input: $logeInViewModel.password
            )
            
            //MARK: - SignUp Button
            Button {
                authecticateNewUser()
            } label: {
                Text("Sign up")
                    .textCase(.uppercase)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange.gradient)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.vertical, 10)
            
            //MARK: - Terms and Privacy
            Text("By clicking on sign up, you have been agreed to our terms and conditions")
                .foregroundColor(.black)
                .font(.footnote)
                .fontWeight(.ultraLight)
                .padding(.bottom, 20)
            
            HStack {
                Text("Already have an account?")
                    .foregroundColor(.black.opacity(0.6))
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Button {
                    logeInViewModel.currentSignView = .logInView
                } label: {
                    Text("Log in")
                        .foregroundColor(.blue)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                
            }
            .padding(.bottom, 5)
        }
        .padding()
        .padding(.vertical, 15)
        
        
    }
    
    func authecticateNewUser() {
        Task {
            do {
                try await logeInViewModel.createNewUser()
                showSignInView = false
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SignUpView(showSignInView: .constant(false))
    }
}
