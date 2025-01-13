//
//  HabitsView.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//


import SwiftUI
import AlertToast

struct HabitsView: View {
    @StateObject var viewModel: HabitViewModel = HabitViewModel()
    @State var showAddHabitView: Bool = false
    @Binding var showSignInView: Bool
    @State private var loading: Bool = false
    @State private var showToast: (
        active: Bool,
        message: String
    ) = (false, "Error")
    
    let loadingSpinner = AlertToast(type: .loading)
    
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
        .toast(isPresenting: $showToast.active) {
            AlertToast(
                displayMode: .banner(.pop),
                type: .error(.red),
                title: "\(showToast.message)"
            )
        }
        .toast(isPresenting: $loading) {
            loadingSpinner
        }
        .task {
            // handle loading
            loading = true
            defer { loading = false }
            // handle loading user habits
            do {
                try await viewModel.loadUserHabits()
            } catch {
                showToast = (active: true, message: error.localizedDescription)
            }
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
                showToast = (active: true, message: error.localizedDescription)
            }
        }
    }
    
}


#Preview {
    NavigationStack {
        HabitsView(viewModel: HabitViewModel(), showSignInView: .constant(false))
    }
}
