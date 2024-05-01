//
//  MessageView.swift
//  sumato
//
//  Created by Nazarii Klymok on 01.05.2024.
//

import SwiftUI

struct MessageView: View {
    var currentMessage: Message
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            if currentMessage.role == "assistant" {
                Image("TanakaLogo")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
            } else {
                Spacer()
            }
            MessageCell(contentMessage: currentMessage.text,
                        role: currentMessage.role)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    MessageView(currentMessage: Message(text: "This is a single message cell with avatar. If user is current user, we won't display the avatar.", role: "assistant"))
}
