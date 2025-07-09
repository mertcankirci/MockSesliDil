//
//  GradientImageView.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 9.07.2025.
//

import SwiftUI

struct GradientImageView: View {
    
    let image: Image
    let colors: [Color]
    let linearGradient: LinearGradient
    
    init(image: Image, colors: [Color]) {
        self.image = image
        self.colors = colors
        self.linearGradient = LinearGradient(colors: colors, startPoint: .bottom, endPoint: .top)
    }
    
    var body: some View {
        
        ZStack {
            image
                .resizable()
                .scaledToFill()
            linearGradient
        }
    }
}

#Preview {
    let image = Image("onboarding-bg-image")
    GradientImageView(image: image, colors: [.black, .black.opacity(0.2)])
}
