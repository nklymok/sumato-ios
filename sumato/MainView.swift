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
    @StateObject private var stats = StatsViewModel()
    @StateObject var appState = AppState()
    
    var body: some View {
        if user == nil {
            LoginScreen(user: $user)
        } else {
            
            VStack {
                HeaderView(showDango: $showDango)
                Spacer()
                TabView {
                    StudyKanjiView(kanjiStats: stats)
                        .tabItem {
                            Label("Kanji", systemImage: "1.circle")
                        }
                    VStack {
                        Text("Tanaka-さん")
                        
                    }
                    .tabItem {
                        Label("Tanaka-さん", systemImage: "2.circle")
                    }
                    Text("Profile")
                        .tabItem {
                            Label("Profile", systemImage: "3.circle")
                        }
                }
                
            }.onAppear {
                appState.userId = user?.appUserId
                stats.fetchData(forUserId: user?.appUserId)
            }
            .environmentObject(appState)
        }
    }
}

#Preview {
    let mockAppState = AppState()
    mockAppState.showPoints = true
    mockAppState.userId = 1
    return MainView(user: User(id: "1", appUserId: 1, nickname: "name", name: "name", picture: "pic", updatedAt: "updAt"))
}
