//
//  SumatoBanner.swift
//  sumato
//
//  Created by Nazarii Klymok on 19.04.2024.
//

import SwiftUI

let logoColor: Color = .logoMain

struct SumatoBanner: View {
    var body: some View {
        VStack {
            Circle().foregroundColor(logoColor).frame(width: 100, height: 100)
            HStack {
                Text("SUMĀTO")
                    .font(.title)
                    .fontWeight(.semibold)
                VStack {
                    Spacer()
                    Text("(スマト)")
                        .font(.system(size: 16))
                }
            }.frame(width: .infinity, height: 16)
                .padding()
        }.frame(width: .infinity)
    }
}

#Preview {
    SumatoBanner()
}
