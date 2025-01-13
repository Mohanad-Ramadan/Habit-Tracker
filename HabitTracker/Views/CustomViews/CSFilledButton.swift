//
//  CSFilledButton.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 13/01/2025.
//

import SwiftUI

struct CSFilledButton: View {
    let label: String
    let action: () -> Void
    
    init(
        label: String,
        icon: String? = nil,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .textCase(.uppercase)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .frame(height: 50)
                .background(Color.orange.gradient)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}


#Preview {
    CSFilledButton(label: "Hello World", action: {})
}
