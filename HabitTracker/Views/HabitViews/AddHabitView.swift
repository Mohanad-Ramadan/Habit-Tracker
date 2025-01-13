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
        VStack(spacing: 10) {
            DismissButton(dismissAction: {
                dismissView.toggle()
            })
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
    }
    
    //MARK: - Add Habit Contianer
    // break down the view so swift could compile the could
    struct ContianerView: View {
        @FocusState private var fieldInFocus: FocusedField?
        @EnvironmentObject var viewModel: HabitViewModel
        @Binding var dismissView: Bool
        
        @State var habitName: String = ""
        @State var habitGoal: String = ""
        
        @State var isGoalValid: Bool = true
        @State var isNameValid: Bool = true
        
        var body: some View {
            VStack(spacing: 5) {
                CSInputField(
                    isSecureField: false,
                    fieldTitle: "Habit Name",
                    placeHolder: "ex: Drink Water",
                    input: $habitName
                )
                .onSubmit { fieldInFocus = .habitGoal }
                
                HStack(alignment: .lastTextBaseline) {
                    CSInputField(
                        isSecureField: false,
                        fieldTitle: "Goal",
                        placeHolder: "0",
                        input: $habitGoal,
                        keyboardType: .numberPad
                    )
                    .focused($fieldInFocus, equals: .habitGoal)
                    
                    CSFilledButton(label: "Add Habit", action: addHabit)
                }
            }
            .onAppear {
                fieldInFocus = .habitName
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
            viewModel.addHabit(
                habit: Habit(
                    name: habitName,
                    goal: habitGoalMapped,
                    progress: 0,
                    isCompleted: false
                )
            )
            dismissView.toggle()
        }
    }
    
    enum FocusedField: Hashable {
        case habitName, habitGoal
    }
}



#Preview {
    AddHabitView(dismissView: .constant(false))
}
