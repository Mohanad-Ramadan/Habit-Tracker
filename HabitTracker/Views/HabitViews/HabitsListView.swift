//
//  HabitsListView.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 13/01/2025.
//

import SwiftUI

struct HabitsListView: View {
    @EnvironmentObject var viewModel: HabitViewModel
    @Binding var showAddHabitView: Bool
    
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
                        HabitProgressView(habit: habit)
                            .listRowInsets(EdgeInsets())
                    }
                    .onDelete { indexSet in
                        viewModel.removeHabit(at: indexSet, from: .active)
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
                        HabitProgressView(habit: habit, isCompletedView: true)
                            .listRowInsets(EdgeInsets())
                    }
                    .onDelete { indexSet in
                        viewModel.removeHabit(at: indexSet, from: .completed)
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
    }
}

#Preview {
    HabitsListView(showAddHabitView: .constant(false))
}
