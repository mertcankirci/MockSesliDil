//
//  WelcomeScreen.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 9.07.2025.
//

import SwiftUI

struct WelcomeScreen: View {
    
    let colors: [Color] = [.black, .black.opacity(0.2)]
    let image = Image("onboarding-bg-image")
    
    @ObservedObject var loginViewModel: LoginViewModel
    @ObservedObject var onboardingRouter: OnboardingRouter
    
    var body: some View {
        
        let screen = UIScreen.main.bounds
        
        ZStack {
            GradientImageView(image: image, colors: colors)
                .ignoresSafeArea()
                .frame(width: screen.width, height: screen.height)
            
            mainContent()
                .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    func mainContent() -> some View {
        VStack {
            Spacer()
            
            VStack {
                Text("Sesli Dil")
                    .foregroundStyle(.white)
                    .font(.system(size: 46, weight: .bold, design: .default))
                
                Text("Yeni nesil dil ogrenme araci")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .font(.system(size: 18, weight: .regular, design: .default))
            }
            .padding(.bottom, 80)
            
            Spacer()
            
            Button {
                signIn()
            } label: {
                Text("Hadi başlayalım")
                    .foregroundStyle(.black)
                    .font(.system(size: 18, weight: .semibold, design: .default))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 32)
                            .fill(.orange)
                    )
            }
            .padding(.bottom, 80)
        }
    }
    
    private func signIn() {
        Task {
            do {
                try await loginViewModel.signInWithApple()
                onboardingRouter.nextStep()
            } catch {
                //Present error function call.
            }
        }
    }

}

#Preview {
    let appleSignInManager = AppleSignInManager()
    WelcomeScreen(loginViewModel: LoginViewModel(appleSignInManager: appleSignInManager), onboardingRouter: OnboardingRouter())
}
