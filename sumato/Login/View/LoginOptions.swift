//
//  LoginOptions.swift
//  sumato
//
//  Created by Nazarii Klymok on 19.04.2024.
//

import SwiftUI
import Auth0

struct LoginOptions: View {
    @Binding var user: User?
    
    var body: some View {
        VStack {
            Text("Login or Sign Up:")
                .font(.headline)
                .padding()
            
            LoginButton(provider: "Apple", action: self.login)
            LoginButton(provider: "Google", action: self.login)
        }
    }
}

#Preview {
    LoginOptions(user: .constant(nil))
}

extension LoginOptions {
    func login() {
        let credentialsManager = CredentialsManager(authentication: Auth0.authentication())
        
        Auth0
            .webAuth()
            .audience("https://sumato.ai/api")
            .scope("openid profile email read:events offline_access")
            .start { result in
                switch result {
                case .success(let credentials):
                    let didStore = credentialsManager.store(credentials: credentials)
                    print("Credentials: \(credentials)")
                    print("ID token: \(credentials.idToken)")
                    print("Access token: \(credentials.accessToken)")
                    DispatchQueue.main.async {
                        self.user = User(from: credentials.idToken)
                        print("user:", self.user as Any)
                    }
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }
    
    func logout() {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                case .success:
                    self.user = nil
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }
}
