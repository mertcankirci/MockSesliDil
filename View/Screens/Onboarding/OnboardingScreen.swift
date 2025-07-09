//
//  OnboardingScreen.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 9.07.2025.
//

import SwiftUI

struct OnboardingScreen: View {
    
    @StateObject private var onboardingRouter = OnboardingRouter()
    @EnvironmentObject private var appRouter: AppRouter
    @ObservedObject var loginViewModel: LoginViewModel
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            switch onboardingRouter.step {
            case .welcome:
                WelcomeScreen(loginViewModel: loginViewModel, onboardingRouter: onboardingRouter)
            case .name:
                NameScreen(onboardingViewModel: onboardingViewModel)
            case .age:
                AgeScreen()
            case .languageLevel:
                LanguageLevelScreen()
            case .languageGoal:
                LanguageLevelScreen()
            case .interests:
                LanguageLevelScreen()
            }
            
            if !(onboardingRouter.step == .welcome) {
                onboardingButtonGroup()
                    .padding(.horizontal)
            }
        }
        .animation(.easeInOut, value: onboardingRouter.step)
        .onChange(of: onboardingRouter.step) { _ in
            updateTitle()
            updateProgressView()
        }
        .onAppear {
            updateTitle()
            updateProgressView()
        }
    }
    
    @ViewBuilder
    func onboardingButtonGroup() -> some View {
        VStack {
            Text(onboardingViewModel.titleString)
                .font(.title)
                .padding(.top, 64)
            
            Spacer()
            
            HStack {
                Group {
                    if onboardingRouter.hasPreviousStep {
                        Button {
                            onboardingRouter.previousStep()
                        } label: {
                            Text("Previous")
                                .foregroundStyle(.black)
                                .font(.system(size: 18, weight: .semibold, design: .default))
                                .frame(width: 120, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 32)
                                        .fill(.orange)
                                )
                        }
                    }
                    
                    Spacer()
                    
                    if onboardingRouter.hasNextStep {
                        Button {
                            onboardingRouter.nextStep()
                        } label: {
                            Text("Next")
                                .foregroundStyle(.black)
                                .font(.system(size: 18, weight: .semibold, design: .default))
                                .frame(width: 120, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 32)
                                        .fill(.orange)
                                )
                        }
                    }
                }

            }
            .padding(.bottom, 16)
            ProgressView(value: onboardingViewModel.onboardingProgress)
                .tint(.orange)
                .padding(.bottom, 80)
        }
    }
    
    private func updateTitle() {
        onboardingViewModel.getTitleString(for: onboardingRouter.step)
    }
    
    private func updateProgressView() {
        onboardingViewModel.calculateOnboardingProgress(for: onboardingRouter.step)
    }
    
}

#Preview {
    OnboardingScreen(loginViewModel: LoginViewModel(appleSignInManager: AppleSignInManager()), onboardingViewModel: OnboardingViewModel())
}


struct NameScreen: View {
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    var body: some View {
        VStack {
            SDTextField(text: onboardingViewModel.name, title: "Isim")
        }
        .padding(.horizontal)
    }
}

struct AgeScreen: View {
    var body: some View {
        Text("How old are you?")
    }
}

struct LanguageLevelScreen: View {
    var body: some View {
        Text("Select your language level.")
    }
}
