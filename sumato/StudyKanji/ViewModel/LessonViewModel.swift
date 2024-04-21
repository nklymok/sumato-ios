//
//  LessonViewModel.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import SwiftUI

class LessonViewModel: ObservableObject {
    @Published var kanjiFinished: Bool = false
    @Published var kanjis: [Kanji] = []
    @Published var currentKanjiIndex: Int = 0
    
    func goBack() {
        guard currentKanjiIndex > 0 else { return }
        currentKanjiIndex -= 1
    }
    
    func goToNext() {
        guard currentKanjiIndex < kanjis.count - 1 else {
            kanjiFinished = true
            return
        }
        currentKanjiIndex += 1
    }
    
    func fetchData(forUserId userId: Int?) {
        guard let userId = userId else {
            print("User ID is nil")
            return
        }
        
        APIClient.shared.fetchStudyKanjis(forUserId: userId) { result in
            switch result {
            case .success(let lesson):
                DispatchQueue.main.async {
                    self.kanjis = lesson.kanjis
                }
            case .failure(let error):
                print("Error fetching lesson: \(error)")
            }
        }
    }
}
