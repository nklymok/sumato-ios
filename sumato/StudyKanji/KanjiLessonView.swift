//
//  KanjiLessonView.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import SwiftUI

struct KanjiLessonView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var lesson: LessonViewModel = LessonViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            HStack {
                Text("Kanji Lesson")
                    .font(.system(size: 48))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            CustomChipView(text: "💡 Study", backgroundColor: Color(hex: 0xF4E7FF))
            if lesson.kanjis.isEmpty {
                Spacer()
                ProgressView()
                Spacer()
            } else if let currentKanji = lesson.kanjis[safe: lesson.currentKanjiIndex] {
                Spacer()
                KanjiDetailView(kanji: currentKanji)
                Spacer()
                
                HStack(spacing: 60) {
                    Button(action: {
                        if lesson.currentKanjiIndex == 0 {
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            lesson.goBack()
                        }
                    }) {
                        Text("Go back")
                            .underline()
                            .baselineOffset(5)
                    }
                    .fontWeight(.semibold)
                    Button("Got it") {
                        if (lesson.currentKanjiIndex == lesson.kanjis.count - 1) {
                            appState.path.append(StudyKanjiNavigation(viewName: "kanjiPractice", kanjis: []))
                        }
                        lesson.goToNext()
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
        .padding()
        .onAppear {
            lesson.fetchData(forUserId: appState.userId)
        }
    }
}

#Preview {
    let appState = AppState()
    appState.userId = 1
    appState.showPoints = false
    return KanjiLessonView()
        .environmentObject(appState)
}
