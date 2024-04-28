//
//  LessonViewModel.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import SwiftUI

class LessonViewModel: ObservableObject {
    @Published var kanjis: [Kanji] = []
    @Published var userGuess: String = ""
    @Published var currentKanjiIndex: Int = 0
    @Published var correctGuess: Bool? = nil
    @Published var isPractice = false
    @Published var allKanjiGuessed = false
    var appState: AppState?
    
    func goBack() {
        guard currentKanjiIndex > 0 && !isPractice else { return }
        updateKanjiIndex(newIndex: currentKanjiIndex - 1)
    }
    
    func goToNext() {
        if !isPractice {
            guard currentKanjiIndex < kanjis.count - 1 else {
                return
            }
            updateKanjiIndex(newIndex: currentKanjiIndex + 1)
        } else {
            correctGuess = nil
            if let index = kanjis.firstIndex(where: { $0.isGuessed == false }) {
                updateKanjiIndex(newIndex: index)
            } else {
                allKanjiGuessed = true
                self.appState?.showPoints = true
            }
        }
    }
    
    private func updateKanjiIndex(newIndex: Int) {
        self.appState?.showPoints = false
        self.appState?.kanjiIndex = newIndex
        self.currentKanjiIndex = newIndex
    }
    
    func fetchData(forUserId userId: Int?, isReview: Bool) {
        guard let userId = userId else {
            print("User ID is nil")
            return
        }
        
        APIClient.shared.fetchKanjis(forUserId: userId, isReview: isReview) { result in
            switch result {
            case .success(let lesson):
                DispatchQueue.main.async {
                    self.kanjis = lesson.kanjis
                    self.appState?.kanjiIndex = 0
                    self.appState?.totalKanji = lesson.kanjis.count
                }
            case .failure(let error):
                print("Error fetching lesson: \(error)")
            }
        }
    }
    
    func checkAnswer(forUserId userId: Int?) {
        guard let userId = userId else {
            print("User ID is nil")
            return
        }
        
        APIClient.shared.fetchAnswerResult(forUserId: userId, reviewId: kanjis[currentKanjiIndex].reviewId, userAnswer: userGuess) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.userGuess = ""
                    if (response.isCorrect) {
                        self.kanjis[self.currentKanjiIndex].isGuessed = true
                        self.goToNext()
                    } else {
                        self.correctGuess = false
                    }
                }
            case .failure(let error):
                print("Error fetching lesson: \(error)")
            }
        }
        
    }
}

    
