//
//  UserProfileView.swift
//  sumato
//
//  Created by Nazarii Klymok on 27.04.2024.
//

import SwiftUI
import Auth0

struct UserProfileView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var profile = UserProfileViewModel()
    @State private var copied = false
    @State private var showLogoutAlert = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Me")
                    .font(.system(size: 48))
                    .fontWeight(.bold)
                Spacer()
                Button(role: .destructive) {
                    showLogoutAlert = true
                } label: {
                    Text("Logout")
                }
            }
            .padding(.bottom, 100)
            VStack {
                HStack {
                    Text("Nickname: ")
                        .font(.title3)
                        .padding(.leading)
                        .padding(.bottom)
                    TextField(text: $profile.name, prompt: Text("Enter your nickname")) {}
                        .underline(true)
                        .baselineOffset(10)
                        .padding(.bottom)
                        .onChange(of: profile.name) { newValue in
                            let filtered = newValue.filter { $0.isLetter || $0.isNumber || $0 == "_" }
                            if filtered != newValue {
                                profile.name = filtered
                            }
                            if profile.name.count > 20 {
                                profile.name = String(profile.name.prefix(20))
                            }
                        }
                        .onSubmit {
                            guard (3...20).contains(profile.name.count) else { return }
                            profile.updateData(userId: appState.userId)
                        }
                    Spacer()
                }
                HStack {
                    Text("Current level: ")
                        .font(.title3)
                        .padding(.leading)
                    Text("N\(profile.level)")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                if !profile.name.isEmpty && profile.name.count < 3 {
                    Text("Nickname must be 3 to 20 characters long.")
                        .foregroundColor(.red)
                        .padding(.leading)
                }
                VStack {
                    Text("Your student code:")
                        .font(.title3)
                        .padding(.top)
                    
                    HStack {
                        Text("\(profile.publicId)")
                            .font(.subheadline)
                            .padding(.top, 5)
                        Image(systemName: "clipboard")
                            .padding(.top, 1)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.blue, lineWidth: 1)
                    ).onTapGesture {
                        UIPasteboard.general.string = profile.publicId
                        self.copied = true
                    }
                    Text(copied ? "Copied!" : "")
                        .foregroundColor(.green)
                        .padding()
                }
                
            }
            Spacer()
        }
        .onAppear {
            profile.fetchData(userId: appState.userId)
        }
        .alert("Log out", isPresented: $showLogoutAlert) {
            Button("Log out", role: .destructive) {
                CredentialsManager(authentication: Auth0.authentication()).clear()
                NotificationCenter.default.post(name: .authenticationRequired, object: nil)
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to log out?")
        }
        .padding()
    }
    
}

#Preview {
    let appState = AppState()
    appState.path = NavigationPath()
    appState.showPoints = true
    appState.userId = 8
    
    return UserProfileView()
        .environmentObject(appState)
}

