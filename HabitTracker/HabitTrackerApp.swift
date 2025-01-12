//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//

import SwiftUI
import Firebase

@main
struct HabitTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Get GoogleService-Info path
        guard let plistPath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") else {
            fatalError("Couldn't find GoogleService-Info.plist")
        }
        // Get the API key from your bundle
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "GoogleService_API_Key") as? String else {
            fatalError("Missing GoogleService_API_Key")
        }
        // Create Firebase options using the plist content
        guard let options = FirebaseOptions(contentsOfFile: plistPath) else {
            fatalError("Something went wrong when creating FirebaseOptions")
        }
        // Passing the apikey from Secrets.xcconfig
        options.apiKey = apiKey
        // Configure Firebase
        FirebaseApp.configure(options: options)
        return true
    }
}
