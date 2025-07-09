//
//  OnboardingViewModel.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 9.07.2025.
//

import Foundation
import SwiftUI

enum LanguageLevel: String, CaseIterable, Identifiable {
    case a1 = "A1"
    case a2 = "A2"
    case b1 = "B1"
    case b2 = "B2"
    case c1 = "C1"
    case c2 = "C2"
    
    var id: String { rawValue }
}

enum TargetLanguage: String, CaseIterable, Identifiable {
    case english = "İngilizce"
    case spanish = "İspanyolca"
    case french = "Fransızca"
    case german = "Almanca"
    case italian = "İtalyanca"
    case turkish = "Türkçe"
    
    var id: String { rawValue }
}

enum LearningGoal: String, CaseIterable, Identifiable {
    case travel = "Seyahat"
    case work = "İş"
    case exam = "Sınav Hazırlığı"
    case hobby = "Hobi"
    
    var id: String { rawValue }
}

enum Interest: String, CaseIterable, Identifiable {
    case cooking = "Mutfak"
    case sports = "Spor"
    case history = "Tarih"
    case technology = "Teknoloji"
    case art = "Sanat"
    case nature = "Doğa"
    
    var id: String { rawValue }
}


final class OnboardingViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var targetLanguage: TargetLanguage = .english
    @Published var languageLevel: LanguageLevel = .a1
    @Published var learningGoal: LearningGoal = .travel
    @Published var interests: Set<Interest> = []
    
    @Published var titleString: String = "Ismini ogrenebilir miyim"
    @Published var onboardingProgress: Float = 0.0
    
    func getTitleString(for step: OnboardingStep) {
        var title = String()
        
        switch step {
        case .welcome:
            return
        case .name:
            title = "Ismini ogrenebilir miyim"
        case .age:
            title = "Kac yasindasin"
        case .languageLevel:
            title = "Ingilizcede hangi seviyedesin"
        case .languageGoal:
            title = "Hangi seviyeye ulasmayi hedefliyorsun"
        case .interests:
            title = "Ilgi alanlarin neler"
        }
        
        withAnimation {
            titleString = title
        }
    }
    
    func calculateOnboardingProgress(for step: OnboardingStep) {
        let totalSteps = Float(OnboardingStep.count - 1)
        let currentStep = Float(step.rawValue)
        
        var progress = Float()
        
        progress = currentStep / totalSteps
        
        
        withAnimation {
            onboardingProgress = progress
        }
    }
}

