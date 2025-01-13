//
//  AuthViewModel.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//


import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var email = String()
    @Published var password = String()
    @Published var userName = String()
    @Published var currentSignView: SignInViewType = .logInView {
        didSet {
            password = String()
        }
    }
    
    func logIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("Email or Password is empty")
            throw EmptyFieldsError.emialOrPassIsEmpty
        }
        try await AuthenticationManager.shared.logeIn(email: email ,password: password)
    }
    
    func createNewUser() async throws {
        guard !email.isEmpty, !password.isEmpty, !userName.isEmpty else {
            print("Email or Password is empty")
            throw EmptyFieldsError.emialOrPassIsEmpty
        }
        
        try await AuthenticationManager.shared.createNewUser(email: email ,password: password, userName: userName)
    }
}


//MARK: - SignIn Types
enum SignInViewType {
    case logInView, signUpView
}

//MARK: - Empty Fields errors
enum EmptyFieldsError: LocalizedError {
    case emialOrPassIsEmpty
    
    var errorDescription: String? {
        switch self {
        case .emialOrPassIsEmpty:
            return "Email or Password is empty."
        }
    }
}
