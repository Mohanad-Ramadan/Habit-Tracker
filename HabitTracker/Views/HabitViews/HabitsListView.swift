//
//  HabitsListView.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 13/01/2025.
//

import SwiftUI
import AlertToast

struct HabitsListView: View {
    @EnvironmentObject var viewModel: HabitViewModel
    @Binding var showAddHabitView: Bool
    
    @State private var showToast: (
        active: Bool,
        habitName: String
    ) = (false, "habit")
    @State private var showRemoveToast = false
    
    var body: some View {
        List {
            // today's progress
            Section {
                TodayProgressHeaderView()
            } header: {
                Text("Today's Progress")
                    .fontWeight(.semibold)
            }
            
            // habits list section
            if !viewModel.activeHabits.isEmpty {
                Section {
                    ForEach(viewModel.activeHabits) { habit in
                        HabitProgressView(
                            showToast: $showToast,
                            habit: habit
                        )
                        .listRowInsets(EdgeInsets())
                    }
                    .onDelete { indexSet in
                        viewModel.removeHabit(at: indexSet, from: .active)
                        showRemoveToast.toggle()
                    }
                } header: {
                    Text("Active Habits")
                        .fontWeight(.semibold)
                }
            }
            
            // completed list section
            if !viewModel.completedHabits.isEmpty {
                Section {
                    ForEach(viewModel.completedHabits) { habit in
                        HabitProgressView(
                            showToast: .constant((false, "")),
                            habit: habit,
                            isCompletedView: true
                        )
                        .listRowInsets(EdgeInsets())
                    }
                    .onDelete { indexSet in
                        viewModel.removeHabit(at: indexSet, from: .completed)
                        showRemoveToast.toggle()
                    }
                } header: {
                    Text("Completed Habits")
                        .fontWeight(.semibold)
                }
            }
        }
        .background(.orange.opacity(0.1))
        .scrollContentBackground(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottomTrailing) {
            FloatingButton(
                presentHabitCreate: $showAddHabitView,
                animate: false
            )
        }
        .toast(isPresenting: $showToast.active) {
            AlertToast(
                type: .complete(.green),
                title: "You Completed '\(showToast.habitName)' for today!"
            )
        }
        .toast(isPresenting: $showRemoveToast) {
            AlertToast(
                type: .error(.red),
                title: "Habit removed!"
            )
        }
    }
}

#Preview {
    HabitsListView(showAddHabitView: .constant(false))
}
