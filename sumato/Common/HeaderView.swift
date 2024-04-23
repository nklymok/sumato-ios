//
//  HeaderView.swift
//  sumato
//
//  Created by Nazarii Klymok on 20.04.2024.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var state: AppState
    let logoColor: Color = .logoMain
    
    var body: some View {
        HStack {
            Circle().foregroundColor(logoColor).frame(width: 25, height: 25).padding(.leading, 10)
            Text("SUMĀTO").fontWeight(.heavy).font(.system(size: 25))
            Text("(スマト)")
            Spacer()
            if state.showPoints {
                Image("DangoIcon")
                Text("250").padding(.trailing, 10)
            } else {
                Text("学")
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                    .padding(.trailing, -5)
                Text("\((state.kanjiIndex ?? 0) + 1)/\(state.totalKanji ?? 0)")
                    .padding(.trailing, 10)
            }
        }.frame(width: .infinity)
    }
}

#Preview {
    let appState = AppState()
    appState.userId = 1
    appState.showPoints = false
    appState.kanjiIndex = 4
    appState.totalKanji = 5
    return HeaderView()
        .environmentObject(appState)
}
