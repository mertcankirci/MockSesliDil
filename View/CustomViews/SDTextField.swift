//
//  SDTextField.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 9.07.2025.
//

import SwiftUI

struct SDTextField: View {
    
    @State var text: String = ""
    let title: String
    
    var body: some View {
        TextField(title, text: $text)
            .tint(.orange)
            .padding([.leading, .trailing], 12)
            .padding(.vertical, 8)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray)
            }
    }
}

#Preview {
    SDTextField(title: "Isim")
}
