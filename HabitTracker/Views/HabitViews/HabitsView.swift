//
//  HabitsView.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//


import SwiftUI

struct HabitsView: View {
    @StateObject var viewModel: HabitViewModel = HabitViewModel()
    @State var showAddHabitView: Bool = false
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.habits.isEmpty {
                    EmptyHabitsView(showAddHabitView: $showAddHabitView)
                } else {
                    HabitsListView(showAddHabitView: $showAddHabitView)
                }
            }
            .navigationTitle("Habits")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(
                        "logout",
                        systemImage: "rectangle.portrait.and.arrow.forward",
                        action: signOut
                    )
                    .font(Font.system(size: 12))
                    .buttonStyle(.plain)
                    .disabled(showAddHabitView)
                }
            }
            .overlay(showAddHabitView ? AddHabitView(dismissView: $showAddHabitView) : nil)
            .animation(.linear, value: showAddHabitView)
        }
        .task {
            try? await viewModel.loadUserHabits()
        }
        .environmentObject(viewModel)
    }
    
    // signOut method
    func signOut() {
        Task {
            do {
                try await AuthenticationManager.shared.signOut()
                showSignInView = true
            } catch {
                print(error)
            }
        }
    }
    
}


#Preview {
    NavigationStack {
        HabitsView(viewModel: HabitViewModel(), showSignInView: .constant(false))
    }
}
