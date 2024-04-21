//
//  CustomChipView.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import SwiftUI

struct CustomChipView: View {
    let text: String
    let backgroundColor: Color
    
    var body: some View {
        Text(text)
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(6)
            .padding(.trailing, 12)
            .padding(.leading, 12)
            .background(backgroundColor)
            .clipShape(Capsule())
            .foregroundColor(.defaultChip)
    }
}

#Preview {
    CustomChipView(text: "💡 Study", backgroundColor: Color(hex: 0xFFAAAA))
}
