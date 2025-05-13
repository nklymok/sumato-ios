//
//  RealtimeChatView.swift
//  sumato
//
//  Created by Nazarii Klymok on 11.05.2025.
//

import SwiftUI
import OpenAIRealtime

struct RealtimeChatView: View {
    private enum Stage {
        case setup
        case chat
        case summary
    }
    

    @State private var userRole = ""
    @State private var aiRole = ""
    @State private var situationDescription = ""
    @State private var conversation: Conversation?
    @State private var stage: Stage = .setup

    var body: some View {
        NavigationStack {
            content
        }
    }

    @ViewBuilder
    private var content: some View {
        switch stage {
        case .setup:
            ConversationSetupView(
                userRole: $userRole,
                aiRole: $aiRole,
                situationDescription: $situationDescription,
                onStart: startConversation
            )
        case .chat:
            ConversationView(
                userRole: userRole,
                aiRole: aiRole,
                situationDescription: situationDescription
            ) { conv in
                // Receive the finished Conversation for summary
                conversation = conv
                stage = .summary
            }
        case .summary:
            if let conv = conversation {
                ConversationSummaryView(conversation: conv, onDone: reset)
            }
        }
    }
    

    private func startConversation() {
        // Move to the chat stage; ConversationView will create and manage the Conversation
        stage = .chat
    }


    private func reset() {
        userRole = ""
        aiRole = ""
        situationDescription = ""
        conversation = nil
        stage = .setup
    }
}

#Preview {
    RealtimeChatView()
}
