//
//  HeaderView.swift
//  sumato
//
//  Created by Nazarii Klymok on 20.04.2024.
//

import SwiftUI

struct HeaderView: View {
    @Binding var showDango: Bool
    let logoColor: Color = .logoMain
    
    var body: some View {
        HStack {
            Circle().foregroundColor(logoColor).frame(width: 25, height: 25).padding(.leading, 10)
            Text("SUMĀTO").fontWeight(.heavy).font(.system(size: 25))
            Text("(スマト)")
            Spacer()
            if showDango {
                Image("DangoIcon")
                Text("250").padding(.trailing, 10)
            }
        }.frame(width: .infinity)
    }
}

#Preview {
    HeaderView(showDango: .constant(true))
}
