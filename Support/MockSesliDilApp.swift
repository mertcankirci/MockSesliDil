//
//  MockSesliDilApp.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 8.07.2025.
//

import SwiftUI

@main
struct MockSesliDilApp: App {
    let appleSignInManager = AppleSignInManager()
    
    @StateObject private var appRouter = AppRouter()
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(loginViewModel: LoginViewModel(appleSignInManager: appleSignInManager), onboardingViewModel: onboardingViewModel)
                .environmentObject(appRouter)
        }
    }
}
