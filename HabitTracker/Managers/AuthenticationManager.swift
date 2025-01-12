//
//  AuthenticationManager.swift
//  MasteringFirebase
//
//  Created by Mohanad Ramdan on 26/06/2024.
//

import Foundation
import FirebaseAuth

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private init() {}
    
    func getAuthenticatedUser() async throws -> UserData? {
        guard let currentUser = Auth.auth().currentUser else { return nil }
        // persist the user Data
        return try await DataPersistenceManager.shared.getUser(user: UserData(user: currentUser))
    }
    
    func createNewUser(email: String, password: String, userName: String) async throws {
        do {
            let authResults = try await Auth.auth().createUser(withEmail: email, password: password)
            // set display name
            let changeRequest = authResults.user.createProfileChangeRequest()
            changeRequest.displayName = userName
            try await changeRequest.commitChanges()
            // persist user Data
            try DataPersistenceManager.shared.createUser(user: UserData(user: authResults.user))
        } catch {
            throw error
        }
    }
    
    func logeIn(email: String, password: String) async throws {
        do {
            let authResults = try await Auth.auth().signIn(withEmail: email, password: password)
            // persist user Data
            try DataPersistenceManager.shared.createUser(user: UserData(user: authResults.user))
        } catch {
            throw error
        }
    }
    
    func signOut() async throws {
        do {
            try Auth.auth().signOut()
            DataPersistenceManager.shared.removeUser()
        } catch {
            throw error
        }
    }
}
