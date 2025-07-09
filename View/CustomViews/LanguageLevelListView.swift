//
//  LanguageLevelListView.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 9.07.2025.
//

import SwiftUI

struct LanguageLevelListView: View {
    
    let levels: [LanguageLevel] = LanguageLevel.allCases
    @State private var selectedLevel: LanguageLevel? = nil 
    
    var body: some View {
        VStack {
            ForEach(levels) { level in
                SDLanguageLevelCell(
                    languageLevel: level,
                    selectedLevel: $selectedLevel
                )
            }
        }
    }
}


#Preview {
    LanguageLevelListView()
}
