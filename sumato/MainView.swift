//
//  ContentView.swift
//  sumato
//
//  Created by Nazarii Klymok on 19.04.2024.
//

import SwiftUI

import SwiftUI

struct MainView: View {
    @State var user: User?
    @State private var showDango = true
    @StateObject var appState = AppState()
    
    var body: some View {
        if user == nil {
            LoginScreen(user: $user)
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
                    VStack {
                        Text("Tanaka-さん")
                        
                    }
                    .tabItem {
                        Label("Tanaka-さん", systemImage: "2.circle")
                    }
                    UserProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "3.circle")
                        }
                }
                
            }.onAppear {
                appState.userId = user?.appUserId
            }
            .environmentObject(appState)
        }
    }
}

#Preview {
    return MainView(user: User(id: "11", appUserId: 11, nickname: "name", name: "name", picture: "pic", updatedAt: "updAt"))
}
