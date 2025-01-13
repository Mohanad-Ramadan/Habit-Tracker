//
//  DismissButton.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 13/01/2025.
//

import SwiftUI

struct DismissButton: View {
    var dismissAction: () -> Void
    
    var body: some View {
        Button(action: dismissAction) {
            Image(systemName: "xmark")
        }
        .foregroundStyle(.black)
        .frame(width: 40, height: 40)
        .background(Color.white)
        .clipShape(Circle())
        .padding(.bottom, 16)
    }
}

#Preview {
    DismissButton(dismissAction: {})
}
