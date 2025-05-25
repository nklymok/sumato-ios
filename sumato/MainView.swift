//
//  ContentView.swift
//  sumato
//
//  Created by Nazarii Klymok on 19.04.2024.
//

import SwiftUI
import Auth0

struct MainView: View {
    @State var user: User?
    @State private var showDango = true
    @StateObject var appState = AppState()

    /// Allow injecting a user during UI testing to bypass login.
    init(user: User? = nil) {
        _user = State(initialValue: user)
    }
    
    private func attemptAutoLogin() {
        let credentialsManager = CredentialsManager(authentication: Auth0.authentication())
        credentialsManager.credentials { result in
            switch result {
            case .success(let credentials):
                if let currentUser = User(from: credentials.idToken) {
                    DispatchQueue.main.async {
                        self.user = currentUser
                    }
                }
            case .failure:
                break
            }
        }
    }
    
    var body: some View {
        if user == nil {
            LoginScreen(user: $user)
                .onAppear(perform: attemptAutoLogin)
        } else {
            VStack {
                HeaderView()
                    .environmentObject(appState)
                Spacer()
                TabView {
                    StudyKanjiView()
                        .tabItem {
                            Label("Kanji", systemImage: "1.circle")
                        }
                    AiChatView()
                    .tabItem {
                        Label("Tanaka-さん", systemImage: "2.circle")
                    }
                    UserProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "3.circle")
                        }
                    RealtimeChatView()
                        .tabItem {
                            Label("Realtime", systemImage: "4.circle")
                        }
                    LeaderboardView()
                        .tabItem {
                            Label("Leaderboard", systemImage: "5.circle")
                        }
                }
                
            }
            .onReceive(NotificationCenter.default.publisher(for: .authenticationRequired)) { _ in
                self.user = nil
            }
            .onAppear {
                appState.userId = user?.appUserId
                appState.userId = user?.appUserId
            }
            .environmentObject(appState)
        }
    }
}

#Preview {
    return MainView(user: User(id: "3", appUserId: 3, nickname: "name", name: "name", picture: "pic", updatedAt: "updAt"))
}
