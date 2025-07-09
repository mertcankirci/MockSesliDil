//
//  EmailSignInManager.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 8.07.2025.
//

import Foundation

protocol EmailSignInManagable {
    func signIn(username: String, password: String) async throws
}

class EmailSignInManager: EmailSignInManagable {
    let baseUrl = "..."
    
    /// Sign in method with email and password
    /// - Parameters:
    ///   - username: User's email
    ///   - password: User's password
    func signIn(username: String, password: String) async throws {
        let endpoint = "\(baseUrl)/signin"
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidUrl
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
        } catch(let error) {
            throw error
        }
    }
}


