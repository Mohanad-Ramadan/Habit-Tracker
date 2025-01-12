//
//  HabitsView.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//


import SwiftUI

struct HabitsView: View {
    @StateObject var viewModel: HabitViewModel = HabitViewModel()
    @State var presentCreateHabitView: Bool = false
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
                                presentHabitCreate: $presentCreateHabitView,
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
                            presentHabitCreate: $presentCreateHabitView,
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
                }
            }
            .fullScreenCover(isPresented: $presentCreateHabitView) {
                Button("create habit") {
                    viewModel.addHabit(habit: Habit(name: "\(Int.random(in: 1...100))", goal: 5, progress: 0))
                    presentCreateHabitView.toggle()
                }
                .frame(width: 100, height: 100)
            }
        }
        .task {
            try? await viewModel.loadUserHabits()
        }
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
