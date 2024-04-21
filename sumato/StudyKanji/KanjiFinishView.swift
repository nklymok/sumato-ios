//
//  KanjiFinishView.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import SwiftUI

struct KanjiFinishView: View {
    var kanjis: [Kanji]
    
    var body: some View {
        VStack {
            CustomChipView(text: "🤩 Done!", backgroundColor: Color(hex: 0xFFFCB0))
            Text("You’ve earned 🍡 10!")
                .foregroundColor(.secondary)
            Text("Items from the lesson:")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding()
            List {
                ForEach(kanjis, id: \.value) { kanji in
                    HStack {
                        Text(kanji.value)
                            .fontWeight(.semibold)
                            .padding(.trailing, 25)
                        Text(kanji.meaning)
                            .fontWeight(.semibold)
                    }
                }.listRowBackground(Color(hex: 0xF7F7F7))
            }
            .scrollIndicators(.visible)
            .listStyle(.plain)
            .frame(maxHeight: 200)
            .padding(.trailing)
            .padding(.leading)
            .padding(.bottom, 25)
            
            Button("Finish lesson") {
                
            }
            .padding()
            .padding(.trailing, 25)
            .padding(.leading, 25)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(13)
            .fontWeight(.semibold)
        }
    }
}

#Preview {
    let kanji1 = Kanji(value: "一", onyomi: "イチ・イツ", kunyomi: "ひと-・ひと.つ", meaning: "one", koohiiStory: "One down, 2041 to go. ;)", grade: "1", frequency: 2)
    let kanji2 = Kanji(value: "一", onyomi: "イチ・イツ", kunyomi: "ひと-・ひと.つ", meaning: "one", koohiiStory: "One down, 2041 to go. ;)", grade: "1", frequency: 2)
    let kanji3 = Kanji(value: "一", onyomi: "イチ・イツ", kunyomi: "ひと-・ひと.つ", meaning: "one", koohiiStory: "One down, 2041 to go. ;)", grade: "1", frequency: 2)
    let kanji4 = Kanji(value: "一", onyomi: "イチ・イツ", kunyomi: "ひと-・ひと.つ", meaning: "one", koohiiStory: "One down, 2041 to go. ;)", grade: "1", frequency: 2)
    return KanjiFinishView(kanjis: [kanji1, kanji2, kanji3, kanji4, kanji4, kanji4])
}
