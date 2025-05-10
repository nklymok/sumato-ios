//
//  StatsResponse.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import Foundation

struct StatsResponse: Decodable {
    let kanjiLearned: Int
    let kanjiLeftToReview: Int
    let kanjiLeftToStudy: Int
    let nextReviewAt: Date?
    let nextStudyAt: Date?
}
