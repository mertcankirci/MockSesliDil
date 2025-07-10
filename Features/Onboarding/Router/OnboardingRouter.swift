//
//  OnboardingRouter.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 9.07.2025.
//

import Foundation
import SwiftUI

enum OnboardingStep: Int, CaseIterable {
    case welcome
    case languageLevel
    case languageGoal
    case interests
    case age
    
    var next: OnboardingStep? {
        let all = Self.allCases
        guard let index = all.firstIndex(of: self), index + 1 < all.count else { return nil }
        return all[index + 1]
    }
    
    var previous: OnboardingStep? {
        let all = Self.allCases
        guard let index = all.firstIndex(of: self), index > 0 else { return nil }
        return all[index - 1]
    }
    
    static var count: Int {
        self.allCases.count
    }
    
    var isLast: Bool {
        let all = Self.allCases
        let totalCount = all.count
        guard let index = all.firstIndex(of: self) else { return false }
        return totalCount - 1 == index
    }
}

final class OnboardingRouter: ObservableObject {
    @Published var step: OnboardingStep = .welcome
    
    var hasNextStep: Bool {
        step.next != nil
    }
    
    var hasPreviousStep: Bool {
        step.previous != nil && step.previous != .welcome
    }
    
    func nextStep() {
        if let next = step.next {
            withAnimation {
                step = next
            }
        }
    }
    
    func previousStep() {
        if let previous = step.previous, previous != .welcome {
            withAnimation {
                step = previous
            }
        }
    }
}
