//
//  MessageBubbleVIew.swift
//  sumato
//
//  Created by Nazarii Klymok on 13.05.2025.
//

import OpenAIRealtime
import SwiftUI

struct MessageBubble: View {
    let message: Item.Message

    var text: String {
        message.content.map { $0.text ?? "" }.joined()
    }

    var body: some View {
        HStack {
            if message.role == .user {
                Spacer()
            }

            ZStack(alignment: .topTrailing) {
                Text(text)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(message.role == .user ? .blue : .secondary)
                    .cornerRadius(20)
            }

            if message.role == .assistant {
                Spacer()
            }
        }
        .padding(message.role == .user ? .leading : .trailing, 48)
    }

}
