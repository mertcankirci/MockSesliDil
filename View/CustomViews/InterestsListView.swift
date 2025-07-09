//
//  InterestsListView.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 9.07.2025.
//

import SwiftUI

struct InterestsListView: View {
    
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    let interests: [Interest] = Interest.allCases
    
    var body: some View {
        VStack {
            ForEach(interests) { interest in
                SDInterestCell(interest: interest, onboardingViewModel: onboardingViewModel)
            }
        }
    }
}

#Preview {
    InterestsListView(onboardingViewModel: OnboardingViewModel())
}
