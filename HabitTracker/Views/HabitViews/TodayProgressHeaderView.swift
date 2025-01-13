//
//  TodayProgressHeaderView.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//

import SwiftUI

struct TodayProgressHeaderView: View {
    @EnvironmentObject var viewModel: HabitViewModel
    @State private var habitProgress = 5.0
    
    private let minValue = 0.0
    private var maxValue: Double {
        Double(viewModel.habits.count)
    }
    private var progress: Double {
        Double(viewModel.habits.filter{ $0.goal <= $0.progress }.count)
    }
    
    let gradient = Gradient(colors: [.gray, .orange])
    
    var body: some View {
        Gauge(value: progress, in: minValue...maxValue) {
            Label("Today's Progress", systemImage: "figure.run")
        } currentValueLabel: {
            Text(progress, format: .number)
                .foregroundColor(.black)
        }
        .tint(gradient)
        .gaugeStyle(.accessoryCircular)
        .frame(maxWidth: .infinity)
        .scaleEffect(1.5)
        .padding(15)
    }
    
}

#Preview {
    TodayProgressHeaderView()
}
