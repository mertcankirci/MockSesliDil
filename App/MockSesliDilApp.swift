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
    @StateObject private var userinfoViewMdoel = UserInfoViewModel()
    @StateObject private var onboardingViewModel: OnboardingViewModel
    @StateObject private var chatViewModel: ChatViewModel
    
    let webSocketService = WebSocketService(url: URL(string: "ws://localhost:8765")!)
    
    init() {
        let onboardingViewModel = OnboardingViewModel(userId: "", apiService: APIService())
        _onboardingViewModel = StateObject(wrappedValue: onboardingViewModel)
        
        let webSocketViewModel = WebSocketViewModel(webSocketService: webSocketService)
        let chatViewModel = ChatViewModel(webSocketViewModel: webSocketViewModel)
        _chatViewModel = StateObject(wrappedValue: chatViewModel)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                loginViewModel: LoginViewModel(
                    appleSignInManager: appleSignInManager
                ),
                onboardingViewModel: onboardingViewModel,
                userInfoViewModel: userinfoViewMdoel,
                chatViewModel: chatViewModel
            )
            .environmentObject(appRouter)
        }
    }
}
