//
//  TotalLearnedStats.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import SwiftUI

struct TotalLearnedStatsView: View {
    let totalLearned: Int
    
    
    var body: some View {
        HStack {
            Text("You’ve learned")
                .font(.system(size: 16))
                .fontWeight(.bold)
            Text("\(totalLearned) / 2,136")
                .font(.system(size: 24))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text("jōyō kanji")
                .font(.system(size: 16))
                .fontWeight(.bold)
            Spacer()
        }
    }
}

#Preview {
    TotalLearnedStatsView(totalLearned: 5)
}
