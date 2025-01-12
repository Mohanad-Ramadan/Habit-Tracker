//
//  MainView.swift
//  Habit Tracker
//
//  Created by Mohanad Ramdan on 11/01/2025.
//

import SwiftUI

struct MainView: View {
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if authViewModel.userAuthenticated {
                HabitsView()
            } else {
                AuthenticationView()
            }
        }
        .environmentObject(authViewModel)
    }
    
}

#Preview {
    MainView()
}
