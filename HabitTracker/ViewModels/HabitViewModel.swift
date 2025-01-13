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
    
    var activeHabits: [Habit] {
        habits.filter { !$0.isCompleted }
    }
    
    var completedHabits: [Habit] {
        habits.filter { $0.isCompleted }
    }
    
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
    
    func removeHabit(at indexSet: IndexSet, from habitType: HabitType) {
        Task {
            let habitsToRemoveFrom = habitType == .active ? activeHabits : completedHabits
            guard let singleIndex = indexSet.first,
                  singleIndex < habitsToRemoveFrom.count else { return }
            
            let habitToRemove = habitsToRemoveFrom[singleIndex]
            try await userDataManager.removeHabit(habit: habitToRemove)
            self.habits = try await userDataManager.getHabits()
        }
    }
    
    func increaseHabitProgress(habit: Habit, completion: (() -> Void)? = nil) {
        Task {
            // abort if progress reached goal
            guard habit.progress < habit.goal else { return }
            // update habit data
            let newProgress = habit.progress + 1
            let isHabitCompleted = newProgress == habit.goal
            // remove the habit
            try await userDataManager.removeHabit(habit: habit)
            // create the habit with the updated progress
            let updatedHabit = Habit(
                name: habit.name,
                goal: habit.goal,
                progress: newProgress,
                isCompleted: isHabitCompleted
            )
            try await userDataManager.createHabit(habit: updatedHabit)
            // fetch the new habits
            self.habits = try await userDataManager.getHabits()
            // 
            if isHabitCompleted {
                completion?()
            }
        }
    }
    
    
    enum HabitType {
        case active
        case completed
    }
    
}
