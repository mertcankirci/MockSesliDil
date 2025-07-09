//
//  SDInterestCell.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 9.07.2025.
//

import SwiftUI

struct SDInterestCell: View {
    
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    
    let interest: Interest
    let iconName: String
    let iconColor: Color
    
    @State private var isSelected: Bool = false
    
    init(interest: Interest, onboardingViewModel: OnboardingViewModel) {
         self.interest = interest
         self.iconName = interest.icon
         self.iconColor = interest.color
         self._onboardingViewModel = ObservedObject(wrappedValue: onboardingViewModel)
     }
    
    var body: some View {
        Button {
            handleButtonClick()
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
        withAnimation {
            isSelected.toggle()
        }
        
        if isSelected {
            onboardingViewModel.addInterest(interest)
        } else {
            onboardingViewModel.popInterest(interest)
        }
    }
}

#Preview {
    SDInterestCell(interest: .art, onboardingViewModel: OnboardingViewModel())
}
