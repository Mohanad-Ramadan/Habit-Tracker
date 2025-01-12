//
//  HabitViewModel.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//

import Foundation

@MainActor
final class HabitViewModel: ObservableObject {
    @Published var habits : [String] = []
}
