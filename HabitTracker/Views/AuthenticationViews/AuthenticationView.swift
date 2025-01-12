//
//  AuthenticationView.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 12/01/2025.
//


import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var signViewModel: AuthViewModel
    @State var animatelogeIn: Bool = true
    @State var animateSignUP: Bool = false
    @Binding var showSignInView: Bool
    // signView boolen computed property
    var islogeInView: Bool { signViewModel.currentSignView == .logInView }
    
    // body
    var body: some View {
        NavigationStack{
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                LogInView(showSignInView: $showSignInView)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
                    .offset(x: islogeInView ? 0:-500)
                    .padding()
                
                SignUpView(showSignInView: $showSignInView)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
                    .offset(x: !islogeInView ? 0:500)
                    .padding()
                    .transition(.slide)
                
            }
            .animation(.smooth(), value: islogeInView)
        }
    }
    
}


#Preview {
    NavigationStack {
        AuthenticationView(showSignInView: .constant(true))
    }
}
