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
    
    func removeHabit(habit: Habit) {
        Task {
            try await userDataManager.removeHabit(habit: habit)
            self.habits = try await userDataManager.getHabits()
        }
    }
    
    func increaseHabitProgress(habit: Habit, by : Int) {
        Task {
            try await userDataManager.updateHabitProgress(habit: habit, newProgress: 1)
            self.habits = try await userDataManager.getHabits()
        }
    }
}
