//
//  SDLanguageLevelCell.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 9.07.2025.
//

import SwiftUI

struct SDLanguageLevelCell: View {
    
    let languageLevel: LanguageLevel
    @Binding var selectedLevel: LanguageLevel?
    
    private var isSelected: Bool {
        selectedLevel == languageLevel
    }
    
    var body: some View {
        Button {
            withAnimation {
                selectedLevel = languageLevel
            }
        } label: {
            HStack {
                Text("\(languageLevel.rawValue)-")
                    .foregroundColor(.primary)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(languageLevel.description)
                    .foregroundColor(.primary)
                    .font(.headline)
                    .fontWeight(.regular)
                
                Spacer()
                
                Circle()
                    .fill(isSelected ? .black : .clear)
                    .overlay(
                        Circle()
                            .stroke(.black, lineWidth: 2)
                    )
                    .frame(width: 12, height: 12)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? .green.opacity(0.6) : Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    SDLanguageLevelCell(languageLevel: .a1, selectedLevel: .constant(.a1))
}
