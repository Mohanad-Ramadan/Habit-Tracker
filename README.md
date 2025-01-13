# HabitTracker

A SwiftUI-based iOS application that helps users track and maintain their daily habits with progress monitoring and completion tracking.

## Features

### User Authentication
- Email-based user registration and login
- Secure authentication using Firebase
- Persistent login state
![ScreenShot](/ScreenShots/Login.png)
![ScreenShot](/ScreenShots/Signup.png)

### Habit Management
- Create personalized habits with custom goals
- Track progress for each habit
- Delete unwanted habits
- Automatic completion marking when goal is reached
![ScreenShot](/ScreenShots/RemoveHabit.png)

### Progress Tracking
- Visual progress indicators for each habit
- Separate views for active and completed habits
- Daily progress overview
![ScreenShot](/ScreenShots/CompletedHabit.png)
![ScreenShot](/ScreenShots/MainScreen.png)

### User Interface
- Clean, intuitive design
- Animated floating action button
- Toast notifications for user feedback
- Keyboard-aware forms
![ScreenShot](/ScreenShots/AddHabit.png)
![ScreenShot](/ScreenShots/EmptyList.png)

## Requirements

- iOS 16.0+
- Xcode 14.0+
- Firebase account for backend services
- CocoaPods or Swift Package Manager for dependencies

## Important Note

- The API key for GoogleService is located in Secrets.xcconfig
  Note: For this trial version, API keys are included directly in the config file

## Dependencies

- FirebaseAuth: User authentication
- FirebaseFirestore: Data persistence
- AlertToast: User notifications

## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture pattern:
- Models: Data structures for User and Habit
- Views: SwiftUI views for UI components
- ViewModels: Business logic and data management

### Concurrency

The app leverages Swift's modern concurrency system with async/await for handling asynchronous operations:

- **Network Calls**: All Firebase operations (authentication, data fetching/writing) use async/await instead of completion handlers
- **Error Handling**: Structured concurrency with do-catch blocks for better error management
- **Main Actor**: @MainActor attribute ensures UI updates occur on the main thread
- **Task Management**: 
  - Async tasks for database operations
  - Proper task cancellation when views disappear

Example of the implemented pattern:
```swift
@MainActor
func loadUserHabits() async throws {
    let user = try await AuthenticationManager.shared.getAuthenticatedUser()
    habits = user?.habits ?? []
}
```

### Design Patterns
- Singleton pattern for service managers (DataPersistenceManager, AuthenticationManager)
- Publisher/Subscriber pattern using @Published for reactive updates
- Dependency injection for view models
