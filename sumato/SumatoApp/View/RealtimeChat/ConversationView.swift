import SwiftUI
import OpenAIRealtime
import AVFAudio

/// A full chat UI that owns its Conversation instance and handles two-way voice streaming.
struct ConversationView: View {
    let userRole: String
    let aiRole: String
    let situationDescription: String
    let onStop: (Conversation) -> Void
    @State private var conversation = Conversation(authToken: "sk-proj-123")

    private var prompt: String {
        """
        You are a Japanese language partner helping someone practice a roleplay.
        - User's role: \(userRole)
        - Your role: \(aiRole)
        - Situation: \(situationDescription)
        Talk to the user in Japanese, staying in character. Keep responses short and interactive.
        """
    }

    var body: some View {
        ScrollView {
            ScrollViewReader { scrollView in
                VStack(spacing: 12) {
                    ForEach(conversation.messages, id: \.id) { message in
                        if message.role == .assistant {
                            MessageBubble(message: message)
                                .id(message.id)
                        }
                    }
                }
                .padding()
                .onReceive(conversation.messages.publisher) { message in
                    // Scroll to the latest message
                    withAnimation {
                        scrollView.scrollTo(message.id, anchor: .center)
                    }
                }
            }
        }
        .navigationTitle("Chat")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Stop") {
                    conversation.stopHandlingVoice()
                    onStop(conversation)
                }
            }
        }
        .task {
            do {
                try await conversation.whenConnected {
                    try await conversation.updateSession { session in
                        session.instructions = """
        You are a Japanese language partner helping someone practice a roleplay.
        - User's role: \(userRole)
        - Your role: \(aiRole)
        - Situation: \(situationDescription)
        Talk to the user in Japanese, staying in character. Keep responses short and interactive.
        """
                        session.inputAudioTranscription = Session.InputAudioTranscription()
                    }
                }
                try conversation.startListening()
            } catch {
                print("ConversationView.startConversation failed:", error)
            }
        }
    }
}
