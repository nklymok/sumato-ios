//
//  ChatViewModel.swift
//  sumato
//
//  Created by Nazarii Klymok on 01.05.2024.
//

import SwiftUI

class AiChatViewModel: ObservableObject {
    @Published var messages = [
        Message(
        text: "こんにちは！ How are you? I'm always here to discuss your Japanese progress 😉",
        role: "assistant")
    ]
    @Published var newMessage = ""
    @Published var isTyping = false
    
    func fetchMessages() {
        APIClient.shared.fetchChatMessages { result in
            switch result {
            case .success(let messages):
                DispatchQueue.main.async {
                    if messages.count > 0 {
                        self.messages = []
                    }
                    for message in messages {
                        self.messages.append(message)
                    }
                }
            case .failure(let error):
                print("Error fetching messages: \(error)")
            }
        }
    }
    
    func sendMessage() {
        self.isTyping = true
        let message = Message(text: newMessage, role: "user")
        messages.append(message)
        newMessage = ""
        APIClient.shared.sendMessage(message: message) { result in
            switch result {
            case .success(let message):
                DispatchQueue.main.async {
                    self.messages.append(message)
                    self.isTyping = false
                }
            case .failure(let error):
                print("Error sending message: \(error)")
            }
        }
        
    }
    
}
