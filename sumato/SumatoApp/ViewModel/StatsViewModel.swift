//
//  KanjiStudyData.swift
//  sumato
//
//  Created by Nazarii Klymok on 20.04.2024.
//

import SwiftUI

class StatsViewModel: ObservableObject {
    @Published var dataFetched: Bool = false
    @Published var kanjiLearned: Int = 0
    @Published var kanjiLeftToReview: Int = 0
    @Published var kanjiLeftToStudy: Int = 0
    @Published var nextReviewAt: Date?
    @Published var nextStudyAt: Date?
    
    func fetchData(forUserId userId: Int?) {
        guard let userId = userId else {
            print("User ID is nil")
            return
        }
        
        APIClient.shared.fetchStats(forUserId: userId) { result in
            switch result {
            case .success(let stats):
                DispatchQueue.main.async {
                    self.kanjiLearned = stats.kanjiLearned
                    self.kanjiLeftToReview = stats.kanjiLeftToReview
                    self.kanjiLeftToStudy = stats.kanjiLeftToStudy
                    self.nextReviewAt = stats.nextReviewAt
                    self.nextStudyAt = stats.nextStudyAt
                    self.dataFetched = true
                }
            case .failure(let error):
                print("Error fetching stats: \(error)")
            }
        }
    }
}
