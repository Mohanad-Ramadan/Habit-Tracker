//
//  FirstView.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//


import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismissScreen
    
    var body: some View {
        NavigationStack {
            Button {
                signOut()
                dismissScreen()
            } label: {
                Text("Log out")
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func signOut() {
        Task { 
            do {
                try await AuthenticationManager.shared.signOut()
                authViewModel.userAuthenticated = false
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
