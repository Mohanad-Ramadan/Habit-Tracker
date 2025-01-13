//
//  MainView.swift
//  Habit Tracker
//
//  Created by Mohanad Ramdan on 11/01/2025.
//

import SwiftUI
import AlertToast

struct MainView: View {
    @State private var showSignInView: Bool = false
    @State private var showToast: (
        active: Bool,
        message: String
    ) = (false, "habit")
    
    var body: some View {
        ZStack {
            if !showSignInView {
                HabitsView(showSignInView: $showSignInView)
            }
        }
        .toast(isPresenting: $showToast.active) {
            AlertToast(
                displayMode: .banner(.pop),
                type: .error(.red),
                title: "\(showToast.message)"
            )
        }
        .onAppear {
            Task {
                do {
                    let authUser = try await AuthenticationManager.shared.getAuthenticatedUser()
                    self.showSignInView = authUser == nil
                } catch {
                    let message = error.localizedDescription
                    showToast = (true, message)
                }
            }
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(
                    showSignInView: $showSignInView,
                    showToast: $showToast
                )
                .toast(isPresenting: $showToast.active) {
                    AlertToast(
                        displayMode: .banner(.pop),
                        type: .error(.red),
                        title: "\(showToast.message)"
                    )
                }
            }
        }
    }
    
}

#Preview {
    MainView()
}
