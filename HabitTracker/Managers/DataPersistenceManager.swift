//
//  DataPersistenceManager.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//

import Foundation
import FirebaseFirestore

final class DataPersistenceManager {
    static let shared = DataPersistenceManager()
    
    // note: we could encode and decode the data with spacific codingKeys
    // but for the sake of this trail project we will go with camelCase (swift default encodeing key)
    let decoder = Firestore.Decoder()
    let encoder = Firestore.Encoder()
    
    // we are using the user collection to write or read all the user data
    private let userDB = Firestore.firestore().collection("users")
    private var currentUser: UserData?
    
    private init() {}
    
    // find and get the document of the current user form the database collections
    private func userDocument(user: UserData) -> DocumentReference {
        userDB.document(user.uid)
    }
    
    func createUser(user: UserData) throws {
        // create a new document for this user data
        try userDocument(user: user).setData(from: user, merge: true)
        currentUser = user
    }
    
    // remove currentUser from the app current life cycle
    func removeUser() {
        currentUser = nil
    }
    
    func getUser(user: UserData) async throws -> UserData {
        // get the user in the database
        let userFetched = try await userDocument(user: user).getDocument(as: UserData.self)
        currentUser = userFetched
        return userFetched
    }
    
    func getHabits() async throws -> [Habit] {
        guard let user = currentUser else { return [] }
        let updatedUser = try await getUser(user: user)
        currentUser = updatedUser
        return updatedUser.habits ?? []
    }
    
    func createHabit(habit: Habit) async throws {
        guard let user = currentUser else { return }
        // Use arrayUnion to add new habit
        try await userDocument(user: user).updateData([
            "habits": FieldValue.arrayUnion([try encoder.encode(habit)])
        ])
    }
    
    func removeHabit(habit: Habit) async throws {
        guard let user = currentUser else { return }
        // Use arrayRemove to delete habit
        try await userDocument(user: user).updateData([
            "habits": FieldValue.arrayRemove([try encoder.encode(habit)])
        ])
    }
    
    func updateHabitProgress(habit: Habit, newProgress: Int) async throws {
        guard let user = currentUser else { return }
        
//        // Find habit index in habits array
//        try await userDocument(user: user).updateData([
//            "habits": FieldValue.arrayRemove([try encoder.encode(habit)])
//        ])
        
        // Update the specific habit's progress using array index
        try await userDocument(user: user).updateData([
            "habits.\(String(describing: index)).progress": newProgress
        ])
    }
    
    
    
}

