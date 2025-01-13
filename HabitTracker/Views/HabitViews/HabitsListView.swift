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
            Section {
                ForEach(viewModel.habits, id: \.name) { habit in
                    HabitProgressView(habit: habit)
                        .listRowInsets(EdgeInsets())
                }
                .onDelete(perform: viewModel.removeHabit)
            } header: {
                Text("Habits List")
                    .fontWeight(.semibold)
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
