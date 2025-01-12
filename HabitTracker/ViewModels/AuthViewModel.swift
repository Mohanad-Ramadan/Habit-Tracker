//
//  AuthViewModel.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//


import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var userName = ""
    @Published var userAuthenticated: Bool
    @Published var currentSignView: SignInViewType = .logeInView
    

    init() {
        let currentUser = AuthenticationManager.shared.getAuthenticatedUser()
        userAuthenticated = currentUser != nil ? true: false
    }
    
    func logeIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("Email or Password is empty")
            return
        }
        
        try await AuthenticationManager.shared.logeIn(email: email ,password: password)
        userAuthenticated = true
    }
    
    func createNewUser() async throws {
        guard !email.isEmpty, !password.isEmpty, !userName.isEmpty else {
            print("Email or Password is empty")
            return
        }
        
        try await AuthenticationManager.shared.createNewUser(email: email ,password: password, userName: userName)
        userAuthenticated = true
    }
}


//MARK: - SignIn Types
enum SignInViewType {
    case logeInView, signUpView
}

