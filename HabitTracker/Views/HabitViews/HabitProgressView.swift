//
//  HabitProgressView.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 13/01/2025.
//

import SwiftUI

struct HabitProgressView: View {
    @EnvironmentObject var viewModel: HabitViewModel
    
    // no need to bind habit object
    // cause the parent view already rendering it by default for his changes
    let habit: Habit
    private var maxValue: Double {
        Double(viewModel.habits.first(where: {$0.name == habit.name})?.goal ?? 0)
    }
    private var progress: Double {
        Double(viewModel.habits.first(where: {$0.name == habit.name})?.progress ?? 0)
    }
    
    var isCompletedView: Bool = false
    
    let gradient: Gradient = Gradient(colors: [.gray, .orange])
    let completedGradient: Gradient = Gradient(colors: [.green])
    
    var body: some View {
        ZStack {
            HStack {
                Text(habit.name)
                Spacer()
                Gauge(value: Double(habit.progress), in: 0.0...Double(habit.goal)) {
                    Label("Today's Progress", systemImage: "figure.run")
                } currentValueLabel: {
                    Text(Double(habit.progress), format: .number)
                        .foregroundColor(.gray)
                }
                .tint(isCompletedView ? completedGradient : gradient)
                .opacity(isCompletedView ? 0.8 : 1)
                .gaugeStyle(.accessoryLinear)
                .frame(width: 150)
            }
            
            Button("") {
                viewModel.increaseHabitProgress(habit: habit)
            }
            .disabled(isCompletedView)
        }
        .padding(.leading)
        .padding()
    }
}

#Preview {
    HabitProgressView(habit: Habit(name: "Drink water", goal: 5, progress: 2, isCompleted: true))
}
