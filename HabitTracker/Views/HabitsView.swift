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
                    Text("Empty list \(Image(systemName: "face.dashed"))")
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .overlay(alignment: .bottomTrailing) {
                            FloatingButton(
                                presentHabitCreate: $showAddHabitView,
                                animate: true
                            )
                        }
                } else {
                    List {
                        ForEach(viewModel.habits, id: \.name){ habit in
                            Text(habit.name)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(alignment: .bottomTrailing) {
                        FloatingButton(
                            presentHabitCreate: $showAddHabitView,
                            animate: false
                        )
                    }
                }
            }
            .navigationTitle("Habits")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("logout") {
                        signOut()
                    }
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
