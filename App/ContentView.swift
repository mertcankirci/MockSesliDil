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
    @ObservedObject var userInfoViewModel: UserInfoViewModel
    @ObservedObject var chatViewModel: ChatViewModel
    @EnvironmentObject private var appRouter: AppRouter
    
    var body: some View {
        switch appRouter.currentRoute {
        case .onboarding:
            NavigationView {
                OnboardingScreen(
                    loginViewModel: loginViewModel,
                    onboardingViewModel: onboardingViewModel,
                    userInfoViewModel: userInfoViewModel
                )
            }
        case .mainTabs:
            VStack {
                
                Text(chatViewModel.displayedChunkText)
                
                if chatViewModel.didConnectionClosed {
                    Text("Connection finished!")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.teal)
                        )
                }
                
                
                HStack {
                    Button {
                        chatViewModel.connect()
                    } label: {
                        Text("Baglan")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.green)
                            )
                    }
                    
                    Button {
                        chatViewModel.disconnect()
                    } label: {
                        Text("Baglantiyi kes")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.red)
                            )
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    let appleSignInManager = AppleSignInManager()
    ContentView(
        loginViewModel: LoginViewModel(appleSignInManager: appleSignInManager),
        onboardingViewModel: OnboardingViewModel(userId: "", apiService: APIService()),
        userInfoViewModel: UserInfoViewModel(),
        chatViewModel: ChatViewModel(
            webSocketViewModel: WebSocketViewModel(
                webSocketService: WebSocketService(
                    url: URL(string: "ws://localhost:8765")!)
            )
        )
    )
}
