//
//  UserInfoViewModel.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 10.07.2025.
//

import Foundation

final class UserInfoViewModel: ObservableObject {
    @Published var userData: UserData = UserData(name: "", birthDate: Date(), targetLanguage: .english, languageLevel: .a1, learningGoal: .exam, interests: [])
    
    
    func addInterest(_ interest: Interest) {
        userData.interests.insert(interest)
    }
    
    func popInterest(_ interest: Interest) {
        userData.interests.remove(interest)
    }
}
