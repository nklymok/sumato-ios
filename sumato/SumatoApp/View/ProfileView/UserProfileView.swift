//
//  UserProfileView.swift
//  sumato
//
//  Created by Nazarii Klymok on 27.04.2024.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var profile = UserProfileViewModel()
    @State private var copied = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Me")
                    .font(.system(size: 48))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            .padding(.bottom, 100)
            VStack {
                HStack {
                    Text("Name: ")
                        .font(.title3)
                        .padding(.leading)
                        .padding(.bottom)
                    TextField(text: $profile.name, prompt: Text("Enter your name")) {}
                        .underline(true)
                        .baselineOffset(10)
                        .padding(.bottom)
                        .onSubmit {
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

