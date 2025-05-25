//
//  LoginButton.swift
//  sumato
//
//  Created by Nazarii Klymok on 19.04.2024.
//

import SwiftUI

struct LoginButton: View {
    let provider: String
    let action: () -> Void // Closure for action

    var body: some View {
        Button(action: action) { // Assign the action closure to the Button
            Image("\(provider)Logo")
                .padding(.leading, 5)
                .padding(.top, 5)
                .padding(.bottom, 5)
            Text("\(provider)")
                .frame(maxWidth: .infinity, maxHeight: 30)
                .padding(.leading, -35)
                .fontWeight(.semibold)
        }
        .padding(.trailing, 30)
        .padding(.leading, 30)
        .buttonStyle(.bordered)
        .foregroundColor(.black)
        .accessibilityIdentifier("\(provider.lowercased())_login_button")
    }
}


#Preview {
    LoginButton(provider: "Apple") {}
}
