//
//  RealtimeChatView.swift
//  sumato
//
//  Created by Nazarii Klymok on 11.05.2025.
//

import SwiftUI
import OpenAIRealtime

struct RealtimeChatView: View {
    @State private var userRole: String = ""
    @State private var aiRole: String = ""
    @State private var situationDescription: String = ""
    @State private var hasStarted: Bool = false
    @State private var conversation: Conversation!

    var body: some View {
        Group {
            if !hasStarted {
                VStack(spacing: 16) {
                    TextField("Your role", text: $userRole)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("AI partner's role", text: $aiRole)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Situation description", text: $situationDescription)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Start Conversation") {
                        let prompt = """
                        You are a Japanese language partner helping someone practice a roleplay.
                        - User's role: \(userRole)
                        - Your role: \(aiRole)
                        - Situation: \(situationDescription)
                        Talk to the user in Japanese, staying in character. Keep responses short and interactive.
                        """
                        conversation = Conversation(authToken: "SECRET")
                        Task {
                            try await conversation.whenConnected {
                                try await conversation.updateSession { session in
                                    session.instructions = prompt
                                    session.inputAudioTranscription = Session.InputAudioTranscription()
                                }
                                try await conversation.startListening()
                            }
                        }
                        hasStarted = true
                    }
                    .disabled(userRole.isEmpty || aiRole.isEmpty || situationDescription.isEmpty)
                }
                .padding()
            } else {
                ScrollView {
                    ScrollViewReader { scrollView in
                        VStack(spacing: 12) {
                            ForEach(conversation.messages, id: \.id) { message in
                                MessageBubble(message: message).id(message.id)
                            }
                        }
                        .padding()
                        .onReceive(conversation.messages.publisher) { _ in
                            withAnimation {
                                scrollView.scrollTo(conversation.messages.last?.id, anchor: .center)
                            }
                        }
                    }
                }
                .navigationTitle("Chat")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    RealtimeChatView()
}
