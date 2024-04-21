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
        Auth0
            .webAuth()
            // .useHTTPS() // Use a Universal Link callback URL on iOS 17.4+ / macOS 14.4+
            .start { result in
                switch result {
                case .success(let credentials):
                    self.user = User(from: credentials.idToken)
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }

    func logout() {
        Auth0
            .webAuth()
            // .useHTTPS() // Use a Universal Link logout URL on iOS 17.4+ / macOS 14.4+
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
