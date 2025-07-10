//
//  SDDatePicker.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 9.07.2025.
//

import SwiftUI

struct SDDatePicker: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            DatePicker("",
                       selection: $selectedDate,
                       displayedComponents: [.date])
            .datePickerStyle(.wheel)
            .labelsHidden()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemBackground))
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    SDDatePicker(selectedDate: .constant(Date()))
}
