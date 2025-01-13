//
//  EmptyHabitsView.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 13/01/2025.
//

import SwiftUI

struct EmptyHabitsView: View {
    @Binding var showAddHabitView: Bool
    
    var body: some View {
        Text("Empty list \(Image(systemName: "face.dashed"))")
            .foregroundStyle(.gray)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottomTrailing) {
                FloatingButton(
                    presentHabitCreate: $showAddHabitView,
                    animate: true
                )
            }
            .background(.orange.opacity(0.1))
    }
}

#Preview {
    EmptyHabitsView(showAddHabitView: .constant(false))
}
