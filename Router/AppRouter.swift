//
//  AppRouter.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 9.07.2025.
//

import Foundation

enum AppRoute {
    case onboarding
    case mainTabs
}


final class AppRouter: ObservableObject {
    @Published var currentRoute: AppRoute = .onboarding
}
