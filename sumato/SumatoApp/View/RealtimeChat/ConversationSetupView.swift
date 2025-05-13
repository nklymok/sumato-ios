import SwiftUI

struct ConversationSetupView: View {
    @Binding var userRole: String
    @Binding var aiRole: String
    @Binding var situationDescription: String
    let onStart: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("Simulate Real-Life Conversations")
                .font(.title)
            Text("Enter the roles and situation below to start a roleplay conversation.")
                .font(.subheadline)
                .foregroundColor(.secondary)
            VStack(alignment: .leading, spacing: 8) {
                Text("Your role")
                    .font(.headline)
                TextField("Your role", text: $userRole)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("The part you will be playing in the conversation.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("AI partner's role")
                    .font(.headline)
                TextField("AI partner's role", text: $aiRole)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("The role the AI will play.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Situation description")
                    .font(.headline)
                TextField("Situation description", text: $situationDescription)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Briefly describe the scenario to set context.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Button("Start Conversation", action: onStart)
                .disabled(userRole.isEmpty || aiRole.isEmpty || situationDescription.isEmpty)
                .padding(.top)
            Spacer()
        }
        .padding()
    }
}