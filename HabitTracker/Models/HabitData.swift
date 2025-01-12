//
//  HabitData.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//

import Foundation

struct Habit: Codable {
    let name: String
    let goal: Int
    var progress: Int
}
