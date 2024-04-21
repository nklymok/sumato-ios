//
//  KanjiDetailView.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import SwiftUI

struct KanjiDetailView: View {
    let kanji: Kanji
    
    var body: some View {
        VStack {
            VStack {
                Text(kanji.value)
                    .font(.system(size: 72))
                    .fontWeight(.bold)
                Text(kanji.meaning)
                    .font(.title)
                    .fontWeight(.bold)
                VStack {
                    HStack(spacing: 5) {
                        Text("On:")
                            .font(.title2)
                            .fontWeight(.medium)
                        Text(kanji.onyomi)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    HStack(spacing: 5) {
                        Text("Kun:")
                            .font(.title2)
                            .fontWeight(.medium)
                        Text(kanji.kunyomi)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                }
                .padding()
                VStack {
                    Text("Kōhii story:")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.bottom, 5)
                    Text(kanji.koohiiStory)
                        .font(.title)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    let kanji = Kanji(reviewId: 1, value: "一", onyomi: "イチ・イツ", kunyomi: "ひと-・ひと.つ", meaning: "one", koohiiStory: "One down, 2041 to go. ;)", grade: "1", frequency: 2, isGuessed: false)
    return KanjiDetailView(kanji: kanji)
}
