//
//  MainView.swift
//  Habit Tracker
//
//  Created by Mohanad Ramdan on 11/01/2025.
//

import SwiftUI

struct MainView: View {
    @StateObject var authViewModel = AuthViewModel()
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            if !showSignInView {
                HabitsView(showSignInView: $showSignInView)
                    .environmentObject(authViewModel)
            }
        }
        .onAppear {
            let authUser = AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
                    .environmentObject(authViewModel)
            }
        }
    }
    
}

#Preview {
    MainView()
}
