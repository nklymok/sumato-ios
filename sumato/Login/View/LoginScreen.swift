//
//  LoginScreen.swift
//  sumato
//
//  Created by Nazarii Klymok on 19.04.2024.
//

import SwiftUI


struct LoginScreen: View {
    @Binding var user: User?
    
    var body: some View {
        VStack {
            SumatoBanner()
            LoginOptions(user: $user)
        }
    }
}

#Preview {
    LoginScreen(user: .constant(nil))
}
