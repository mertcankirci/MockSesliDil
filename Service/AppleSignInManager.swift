//
//  AppleSignInManager.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 8.07.2025.
//

import Foundation
import AuthenticationServices

protocol AppleSignInManagable {
    func startSignInWithAppleFlow() async throws -> AppleSignInUser
    var continuation: CheckedContinuation<AppleSignInUser, Error>? { get }
}

final class AppleSignInManager: NSObject, AppleSignInManagable {
    var continuation: CheckedContinuation<AppleSignInUser, Error>?
    
    /// Starts sign in with apple flow
    /// - Returns: Apple user
    func startSignInWithAppleFlow() async throws -> AppleSignInUser {
        
        guard continuation == nil else {
            throw ApplESignInError.alreadySigningIn
        }
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.email, .fullName]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
        return try await withCheckedThrowingContinuation { contuation in
            self.continuation = contuation
        }
    }
}

//MARK: - ASAuthorizationControllerDelegate -

extension AppleSignInManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            continuation?.resume(throwing: ApplESignInError.invalidResponse)
            return
        }
        
        let email = credential.email
        let fullName = credential.fullName?.givenName
        let userId = credential.user
        
        let appleUser = AppleSignInUser(userId: userId, fullName: fullName, email: email)
        
        continuation?.resume(returning: appleUser)
        
        continuation = nil
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        #if DEBUG
        print("Error in apple sign in: \(error)")
        #endif
        continuation?.resume(throwing: error)
        
        continuation = nil
    }
}

//MARK: - ASAuthorizationControllerPresentatationContextProviding -

extension AppleSignInManager: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first ?? UIWindow()
    }
}
