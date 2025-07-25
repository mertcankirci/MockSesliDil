//
//  SDInterestCell.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 9.07.2025.
//

import SwiftUI

struct SDInterestCell: View {
    
    @ObservedObject var userInfoViewModel: UserInfoViewModel
    
    let interest: Interest
    let iconName: String
    let iconColor: Color
    
    private var isSelected: Bool {
        userInfoViewModel.userData.interests.contains(interest)
    }
    
    init(interest: Interest, userInfoViewModel: UserInfoViewModel) {
        self.interest = interest
        self.iconName = interest.icon
        self.iconColor = interest.color
        self._userInfoViewModel = ObservedObject(wrappedValue: userInfoViewModel)
    }
    
    var body: some View {
        Button {
            withAnimation {
                handleButtonClick()
            }
        } label: {
            HStack(spacing: 32) {
                Image(systemName: iconName)
                    .foregroundStyle(.white)
                    .imageScale(.medium)
                    .padding(8)
                    .background(
                        Circle()
                            .fill(iconColor)
                    )
                
                Text(interest.description)
                    .foregroundColor(.primary)
                    .font(.headline)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? .green.opacity(0.6) : Color(.secondarySystemBackground))
        )
    }
    
    private func handleButtonClick() {
        if isSelected {
            userInfoViewModel.popInterest(interest)
        } else {
            userInfoViewModel.addInterest(interest)
        }
    }
}

#Preview {
    SDInterestCell(interest: .art, userInfoViewModel: UserInfoViewModel())
}
