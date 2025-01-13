//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 13/01/2025.
//

import SwiftUI

//MARK: - AddHabitView
struct AddHabitView: View {
    @Binding var dismissView: Bool
    let viewWidth = UIScreen.main.bounds.width * 0.8
    
    var body: some View {
        Group {
            Group {
                ContianerView(dismissView: $dismissView)
                .padding(.top)
                .padding(20)
            }
            .frame(width: viewWidth)
            .background(.white)
            .cornerRadius(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.5))
        .ignoresSafeArea()
        .onTapGesture { dismissView.toggle() }
    }
    
}

//MARK: - Add Habit Contianer
// break down the view so swift could compile the could
struct ContianerView: View {
    @EnvironmentObject var viewModel: HabitViewModel
    @Binding var dismissView: Bool
    
    @State var habitName: String = ""
    @State var habitGoal: String = ""
    
    @State var isGoalValid: Bool = true
    @State var isNameValid: Bool = true
    
    let charactersLimit = 25
    
    var body: some View {
        VStack(spacing: 5) {
            CSInputField(
                isSecureField: false,
                fieldTitle: "Habit Name",
                placeHolder: "ex: Drink Water",
                input: $habitName
            )
            .onChange(of: habitName) { _, newValue in
                let sanitizedValue = newValue.sanitizeInput(charactersLimit: charactersLimit)
                habitName = sanitizedValue
            }
            HStack(alignment: .lastTextBaseline) {
                CSInputField(
                    isSecureField: false,
                    fieldTitle: "Goal",
                    placeHolder: "0",
                    input: $habitGoal,
                    keyboardType: .numberPad
                )
                CSFilledButton(label: "Add Habit", action: addHabit)
            }
        }
    }
    // Add new habit logic
    private func addHabit() {
        // check if habitGoal not nil or equal to 0
        guard let habitGoalMapped = Int(habitGoal), habitGoalMapped > 0 else {
            isGoalValid = false
            return
        }
        // check if added before
        let isHabitAddedBefore = viewModel.habits.contains(where: { $0.name == habitName })
        guard !habitName.isEmpty, !isHabitAddedBefore else {
            isNameValid = false
            return
        }
        // add habit to dataBase and dismiss view
        viewModel.addHabit(habit: Habit(name: habitName, goal: habitGoalMapped, progress: 0))
        dismissView.toggle()
    }
}

#Preview {
    AddHabitView(dismissView: .constant(false))
}
