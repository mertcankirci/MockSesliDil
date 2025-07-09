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
    
    var description: String {
        switch self {
        case .a1:
            return "Beginner"
        case .a2:
            return "Elementary"
        case .b1:
            return "Intermediate"
        case .b2:
            return "Upper-Intermediate"
        case .c1:
            return "Advanced"
        case .c2:
            return "Proficient"
        }
    }
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
    
    var description: String {
        switch self {
        case .cooking:
            return "Yemek ve mutfak kültürü"
        case .sports:
            return "Sporlar ve aktif yaşam"
        case .history:
            return "Tarih ve geçmiş olaylar"
        case .technology:
            return "Teknoloji ve dijital dünya"
        case .art:
            return "Sanat ve yaratıcılık"
        case .nature:
            return "Doğa ve çevre"
        }
    }
    
    var icon: String {
        switch self {
        case .cooking:
            return "fork.knife"
        case .sports:
            return "sportscourt"
        case .history:
            return "book"
        case .technology:
            return "desktopcomputer"
        case .art:
            return "paintpalette"
        case .nature:
            return "leaf"
        }
    }
    
    var color: Color {
        switch self {
        case .cooking:
            return .orange
        case .sports:
            return .blue
        case .history:
            return .brown
        case .technology:
            return .purple
        case .art:
            return .pink
        case .nature:
            return .green
        }
    }
}




final class OnboardingViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var birthDate: Date = Date()
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
        case .languageLevel:
            title = "Ingilizcede hangi seviyedesin"
        case .languageGoal:
            title = "Hangi seviyeye ulasmayi hedefliyorsun"
        case .interests:
            title = "Ilgi alanlarin neler"
        case .age:
            title = "Kac yasindasin"
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
    
    func addInterest(_ interest: Interest) {
        interests.insert(interest)
    }
    
    func popInterest(_ interest: Interest) {
        interests.remove(interest)
    }
}

