//
//  AppRouter.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 9.07.2025.
//

import Foundation
import SwiftUI

enum AppRoute {
    case onboarding
    case mainTabs
}


final class AppRouter: ObservableObject {
    @Published var currentRoute: AppRoute = .onboarding
    
    func switchToMainTabs() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            withAnimation {
                self.currentRoute = .mainTabs
            }
        }
    }
}
