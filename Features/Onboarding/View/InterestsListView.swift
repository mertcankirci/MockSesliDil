//
//  InterestsListView.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 9.07.2025.
//

import SwiftUI

struct InterestsListView: View {
    
    @ObservedObject var userInfoViewModel: UserInfoViewModel
    let interests: [Interest] = Interest.allCases
    
    var body: some View {
        VStack {
            ForEach(interests) { interest in
                SDInterestCell(interest: interest, userInfoViewModel: userInfoViewModel)
                
            }
        }
    }
}

#Preview {
    InterestsListView(userInfoViewModel: UserInfoViewModel())
}
