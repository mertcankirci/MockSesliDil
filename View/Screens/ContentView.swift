//
//  ContentView.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 8.07.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var loginViewModel: LoginViewModel
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    @EnvironmentObject private var appRouter: AppRouter
    
    var body: some View {
        switch appRouter.currentRoute {
        case .onboarding:
            NavigationView {
                OnboardingScreen(
                    loginViewModel: loginViewModel,
                    onboardingViewModel: onboardingViewModel
                )
            }
        case .mainTabs:
            VStack {
                Text("Hello")
            }
        }
    }
}

#Preview {
    let appleSignInManager = AppleSignInManager()
    ContentView(
        loginViewModel: LoginViewModel(appleSignInManager: appleSignInManager),
        onboardingViewModel: OnboardingViewModel()
    )
}
