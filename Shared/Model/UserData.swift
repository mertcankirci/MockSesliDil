//
//  UserData.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 10.07.2025.
//

import Foundation

struct UserData: Codable {
    var name: String
    var birthDate: Date
    var targetLanguage: TargetLanguage
    var languageLevel: LanguageLevel
    var learningGoal: LearningGoal
    var interests: Set<Interest> 
}
