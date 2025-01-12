//
//  FloatingButton.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//

import SwiftUI

struct FloatingButton: View {
    @Binding var presentHabitCreate: Bool
    @State var animate: Bool = false
    
    var body: some View {
        Button {
            presentHabitCreate = true
        } label: {
            Image(systemName: "plus")
                .scaleEffect(1.3)
                .foregroundColor(.white)
                .frame(width: 60,height: 60)
                .background(animate ? .purple : .orange)
                .cornerRadius(50)
                .padding()
        }
        .scaleEffect(animate ? 1.2 : 1)
        .offset(x: animate ? -30 : -20, y: animate ? -5 : 0)
        .shadow(
            color: animate ? Color.purple.opacity(0.8) : Color.orange.opacity(0.5),
            radius: animate ? 30 : 10,
            x: 0,
            y: 0
        )
        .onAppear {
            guard animate else { return }
            withAnimation(
                Animation
                    .easeInOut(duration: 2)
                    .repeatForever()
            ){
                animate.toggle()
            }
        }
    }
    

}

#Preview {
    FloatingButton(presentHabitCreate: .constant(false), animate: true)
}
