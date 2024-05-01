//
//  MessageView.swift
//  sumato
//
//  Created by Nazarii Klymok on 01.05.2024.
//

import SwiftUI

struct MessageCell: View {
    var contentMessage: String
    var role: String
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(role != "assistant" ? Color.white : Color.black)
            .background(role != "assistant" ? Color.blue : Color(UIColor.systemGray6 ))
            .cornerRadius(10)
    }
}

#Preview {
    MessageCell(contentMessage: "This is a single message cell.", role: "assistant")
}
