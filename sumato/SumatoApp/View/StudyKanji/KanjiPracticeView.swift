//
//  KanjiPracticeView.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import ConfettiSwiftUI
import SwiftUI

struct KanjiPracticeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var lesson: LessonViewModel = LessonViewModel()
    @EnvironmentObject var appState: AppState
    
    var isReview: Bool; // review or study
    
    func handleSubmit() {
        if (lesson.correctGuess == nil) {
            lesson.checkAnswer(forUserId: appState.userId)
        } else {
            lesson.correctGuess = nil
            lesson.goToNext()
        }
    }
    
    var body: some View {
        VStack {
            if lesson.allKanjiGuessed == true {
                KanjiFinishView(kanjis: lesson.kanjis)
            } else {
                HStack {
                    Text("Kanji Lesson")
                        .font(.system(size: 48))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                CustomChipView(text: "✏️ Practice", backgroundColor: Color(hex: 0xB4FFC5))
                if lesson.kanjis.isEmpty {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if let currentKanji = lesson.kanjis[safe: lesson.currentKanjiIndex] {
                    Spacer()
                    if lesson.correctGuess == false {
                        KanjiWrongView(kanji: currentKanji)
                    } else {
                        
                        KanjiQuestionView(kanji: currentKanji)
                    }
                    VStack(spacing: 0) {
                        if lesson.correctGuess == nil {
                            TextField(text: $lesson.userGuess, prompt: Text("Your guess")) {}
                                .multilineTextAlignment(.center)
                                .underline()
                                .baselineOffset(10)
                                .padding(.bottom, 20)
                                .onSubmit {
                                    handleSubmit()
                                }
                        } else { }
                        Button("Submit") {
                            handleSubmit()
                        }
                        .padding()
                        .padding(.trailing, 25)
                        .padding(.leading, 25)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(13)
                        .fontWeight(.semibold)
                    }
                    .confettiCannon(trigger: $lesson.confettiTrigger)
                    
                    Spacer()
                    
                }
            }
        }
        .padding()
        .onAppear {
            appState.showPoints = false
            lesson.appState = appState
            lesson.isPractice = true
            lesson.fetchData(forUserId: appState.userId, isReview: isReview)
        }
    }
}

#Preview {
    let appState = AppState()
    appState.userId = 1
    appState.showPoints = false
    return KanjiPracticeView(isReview: true)
        .environmentObject(appState)
}
