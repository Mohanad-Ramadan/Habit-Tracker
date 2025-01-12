//
//  AuthDataResult.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//


import Foundation
import FirebaseAuth

struct AuthDataResult {
    let uid: String
    let email: String?
    let photoURL: URL?
    var userName: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL
        self.userName = user.displayName
    }
    
}