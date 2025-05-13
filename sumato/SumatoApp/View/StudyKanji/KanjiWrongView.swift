//
//  KanjiWrongView.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import SwiftUI

struct KanjiWrongView: View {
    let kanji: Kanji
    
    var body: some View {
        VStack {
            CustomChipView(text: "❌ Wrong", backgroundColor: Color(hex: 0xFFC0C0))
            KanjiDetailView(kanji: kanji)
        }
    }
}

#Preview {
    let kanji = Kanji(reviewId: 1, value: "一", onyomi: "イチ・イツ", kunyomi: "ひと-・ひと.つ", meaning: "one", koohiiStory: "One down, 2041 to go. ;)", grade: "1", isGuessed: false)
    return KanjiWrongView(kanji: kanji)
}
