//
//  HabitsView.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//


import SwiftUI

struct HabitsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismissScreen
    @Binding var showSignInView: Bool
    
    @StateObject var habitsViewModel: HabitViewModel = HabitViewModel()
    @State var presentHabitCreate: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if habitsViewModel.habits.isEmpty {
                    Text("Empty list \(Image(systemName: "face.dashed"))")
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .overlay(alignment: .bottomTrailing) {
                            FloatingButton(
                                presentHabitCreate: $presentHabitCreate,
                                animate: true
                            )
                        }
                } else {
                    List {
                        ForEach(habitsViewModel.habits, id: \.self){ item in
                            Text(item)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(alignment: .bottomTrailing) {
                        FloatingButton(
                            presentHabitCreate: $presentHabitCreate,
                            animate: false
                        )
                    }
                }
            }
            .navigationTitle("Habits")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("logout") {
                        signOut()
                    }
                }
            }
        }
        
    }
    
    // signOut method
    func signOut() {
        Task {
            do {
                try await AuthenticationManager.shared.signOut()
                showSignInView = true
//                dismissScreen()
            } catch {
                print(error)
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        HabitsView(showSignInView: .constant(false), habitsViewModel: HabitViewModel())
    }
}
