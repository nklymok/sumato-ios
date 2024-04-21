//
//  KanjiQuestionView.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import SwiftUI

struct KanjiQuestionView: View {
    let kanji: Kanji
    
    var body: some View {
        VStack {
            Text(kanji.value)
                .font(.system(size: 72))
                .fontWeight(.bold)
            Text("What's this kanji?")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    let kanji = Kanji(reviewId: 1, value: "一", onyomi: "イチ・イツ", kunyomi: "ひと-・ひと.つ", meaning: "one", koohiiStory: "One down, 2041 to go. ;)", grade: "1", frequency: 2, isGuessed: false)
    return KanjiQuestionView(kanji: kanji)
}
