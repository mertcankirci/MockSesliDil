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
    @ObservedObject var userInfoViewModel: UserInfoViewModel
    
    var body: some View {
        ZStack {
            switch onboardingRouter.step {
            case .welcome:
                WelcomeScreen(loginViewModel: loginViewModel, onboardingRouter: onboardingRouter, onboardingViewModel: onboardingViewModel)
            case .languageLevel:
                LanguageLevelScreen(userInfoViewModel: userInfoViewModel)
            case .interests:
                InterestsScreen(userInfoViewModel: userInfoViewModel)
            case .languageGoal:
                LanguageLevelScreen(userInfoViewModel: userInfoViewModel)
            case .age:
                AgeScreen(userInfoViewModel: userInfoViewModel)
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
                    
                    Button {
                        if !onboardingRouter.step.isLast {
                            onboardingRouter.nextStep()
                        } else {
                            onboardingViewModel.completeOnboarding()
                            appRouter.switchToMainTabs()
                        }
                    } label: {
                        Text(onboardingRouter.step.isLast ? "Finish" :"Next")
                            .foregroundStyle(.black)
                            .font(.system(size: 18, weight: .semibold, design: .default))
                            .frame(width: 120, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 32)
                                    .fill(onboardingRouter.step.isLast ? .green.opacity(0.6) : .orange)
                            )
                    }
                }
            }
            .padding(.bottom, 16)
            
            ProgressView(value: onboardingViewModel.onboardingProgress)
                .tint(.orange)
                .padding(.bottom, 64)
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
    OnboardingScreen(loginViewModel: LoginViewModel(appleSignInManager: AppleSignInManager()), onboardingViewModel: OnboardingViewModel(userId: "", apiService: APIService()), userInfoViewModel: UserInfoViewModel())
}

struct AgeScreen: View {
    @ObservedObject var userInfoViewModel: UserInfoViewModel
    var body: some View {
        VStack {
            SDDatePicker(selectedDate: $userInfoViewModel.userData.birthDate)
        }
        .padding()
    }
}

struct LanguageLevelScreen: View {
    
    @ObservedObject var userInfoViewModel: UserInfoViewModel
    
    var body: some View {
        VStack {
            LanguageLevelListView(selectedLevel: $userInfoViewModel.userData.languageLevel)
                .padding()
        }
    }
}

struct InterestsScreen: View {
    
    @ObservedObject var userInfoViewModel: UserInfoViewModel
    
    var body: some View {
        VStack {
            InterestsListView(userInfoViewModel: userInfoViewModel)
        }
        .padding()
    }
}
