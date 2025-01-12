//
//  UserData.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//


import Foundation
import FirebaseAuth

struct UserData: Codable {
    let uid: String
    let email: String?
    var userName: String?
    var habits: [Habit]?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.userName = user.displayName
    }
    
}
