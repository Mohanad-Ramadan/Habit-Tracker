//
//  HabitProgressView.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 13/01/2025.
//

import SwiftUI

struct HabitProgressView: View {
    @EnvironmentObject var viewModel: HabitViewModel
    let habit: Habit
    
    private var maxValue: Double {
        Double(viewModel.habits.first(where: {$0.name == habit.name})?.goal ?? 0)
    }
    private var progress: Double {
        Double(viewModel.habits.first(where: {$0.name == habit.name})?.progress ?? 0)
    }
    
    let gradient: Gradient = Gradient(colors: [.gray, .orange])
    
    var body: some View {
        ZStack {
            HStack {
                Text(habit.name)
                Spacer()
                Gauge(value: progress, in: 0.0...maxValue) {
                    Label("Today's Progress", systemImage: "figure.run")
                } currentValueLabel: {
                    Text(progress, format: .number)
                        .foregroundColor(.gray)
                }
                .tint(gradient)
                .gaugeStyle(.accessoryLinear)
                .frame(width: 150)
            }
            Button("") {
                viewModel.increaseHabitProgress(habit: habit)
            }
        }
        .padding(.leading)
        .padding()
    }
}

#Preview {
    HabitProgressView(habit: Habit(name: "Drink water", goal: 5, progress: 2))
}
