//
//  HabitViewModel.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//

import Foundation

@MainActor
final class HabitViewModel: ObservableObject {
    private let userDataManager = DataPersistenceManager.shared
    @Published private(set) var habits: [Habit] = []
    
    func loadUserHabits() async throws {
        let user = try await AuthenticationManager.shared.getAuthenticatedUser()
        habits = user?.habits ?? []
    }
    
    func addHabit(habit: Habit) {
        Task {
            try await userDataManager.createHabit(habit: habit)
            self.habits = try await userDataManager.getHabits()
        }
    }
    
    func removeHabit(at indexSet: IndexSet) {
        Task {
            guard let singleIndex = indexSet.first else { return }
            let habitToRemove = habits[singleIndex]
            try await userDataManager.removeHabit(habit: habitToRemove)
            self.habits = try await userDataManager.getHabits()
        }
    }
    
    func increaseHabitProgress(habit: Habit) {
        Task {
            // aport if progress reached goal
            guard habit.progress < habit.goal else { return }
            // remove the habit
            try await userDataManager.removeHabit(habit: habit)
            // create the habit with the updated progress
            let updatedHabit = Habit(name: habit.name, goal: habit.goal, progress: habit.progress + 1)
            try await userDataManager.createHabit(habit: updatedHabit)
            self.habits = try await userDataManager.getHabits()
        }
    }
    
}
