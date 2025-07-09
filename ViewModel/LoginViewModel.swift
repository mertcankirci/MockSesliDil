//
//  LoginViewModel.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 8.07.2025.
//

import Foundation

class LoginViewModel: ObservableObject {
    private let appleSignInManager: AppleSignInManagable
    
    @Published var user: AppleSignInUser?
    @Published var errorMessage: String?
    
    init(appleSignInManager: AppleSignInManagable) {
        self.appleSignInManager = appleSignInManager
    }
    
    func signInWithApple() async throws {
        do {
            let result = try await appleSignInManager.startSignInWithAppleFlow()
            #if DEBUG
            print(result)
            #endif
            await MainActor.run {
                user = result
            }
        } catch(let error) {
            self.errorMessage = error.localizedDescription
            throw error
        }
    }
}
