//
//  AiChatView.swift
//  sumato
//
//  Created by Nazarii Klymok on 01.05.2024.
//

import Combine
import SwiftUI

struct AiChatView: View {
    @StateObject private var chat: AiChatViewModel = AiChatViewModel()
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                VStack {
                    HStack {
                        Text("Tanakaさん")
                            .font(.system(size: 48))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    Image("TanakaLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                }
                .padding()
                ScrollViewReader { proxy in
                    VStack {
                        ScrollView {
                            ScrollViewReader { scrollViewReader in
                                // solves the reuse / performance for scrollview and we dont need to use ListView
                                LazyVStack {
                                    ForEach(chat.messages, id: \.self) { message in
                                        MessageView(currentMessage: message)
                                            .listRowSeparator(.hidden)
                                            .id(message.id)
                                    }
                                }
                                .onReceive(Just(chat.messages)) { _ in
                                    withAnimation {
                                        proxy.scrollTo(chat.messages.last?.id, anchor: .bottom)
                                    }
                                }
                            }
                        }
                        
                        HStack {
                            if (chat.isTyping) {
                                TypingIndicator()
                                    .padding(.leading)
                            }
                            Spacer()
                        }
                        HStack {
                            TextField("Send a message", text: $chat.newMessage)
                                .textFieldStyle(.roundedBorder)
                            Button(action: chat.sendMessage) {
                                Image(systemName: "paperplane")
                            }
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                chat.fetchMessages()
                withAnimation {
                    proxy.scrollTo(chat.messages.last?.id, anchor: .bottom)
                }
            }
        }
    }
}

#Preview {
    AiChatView()
}
