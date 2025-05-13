import SwiftUI
import OpenAIRealtime

struct ConversationSummaryView: View {
    let conversation: Conversation
    let onDone: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("Conversation Summary")
                .font(.title)
            Text("Total messages: \(conversation.messages.count)")
                .font(.headline)
            Button("Back to Menu", action: onDone)
                .padding(.top)
            Spacer()
        }
        .padding()
    }
}