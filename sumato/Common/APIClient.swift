//
//  ApiClient.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    private let coreApiClient = CoreAPIClient.shared
    
    func fetchStats(forUserId userId: Int, completion: @escaping (Result<StatsResponse, Error>) -> Void) {
        let urlSuffix = "kanji/\(userId)/stats"
        Task {
            await coreApiClient.makeRequest(urlSuffix: urlSuffix, method: "GET", completion: completion)
        }
    }   
    
    func fetchProfile(forUserId userId: Int, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let urlSuffix = "profile/\(userId)"
        Task {
            await coreApiClient.makeRequest(urlSuffix: urlSuffix, method: "GET", completion: completion)
        }
    }

    func fetchProfileUpdate(forUserId userId: Int, profile: UserProfile, completion: @escaping (Result<Void, Error>) -> Void) {
        let urlSuffix = "profile/\(userId)"
        let requestBody: [String: Any] = [
            "name": profile.name
        ]
        Task {
            await coreApiClient.makeRequest(urlSuffix: urlSuffix, method: "PUT", requestBody: requestBody) { (result: Result<UserProfile, Error>) in
                switch result {
                case .success(_):
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func fetchKanjis(forUserId userId: Int, isReview: Bool, completion: @escaping (Result<LessonResponse, Error>) -> Void) {
        let urlSuffix = "kanji/\(userId)" + (isReview ? "/review" : "/study")
        Task {
            await coreApiClient.makeRequest(urlSuffix: urlSuffix, method: "GET", completion: completion)
        }
    }

    func fetchAnswerResult(forUserId userId: Int, reviewId: Int, userAnswer: String, completion: @escaping (Result<AnswerResultResponse, Error>) -> Void) {
        let urlSuffix = "kanji/\(userId)/answer"
        let requestBody: [String: Any] = [
            "reviewId": reviewId,
            "answer": userAnswer
        ]
        Task {
            await coreApiClient.makeRequest(urlSuffix: urlSuffix, method: "POST", requestBody: requestBody, completion: completion)
        }
    }
    
    func fetchChatMessages(completion: @escaping (Result<[Message], Error>) -> Void) {
        let urlSuffix = "ai-chat/history"
        Task {
            await coreApiClient.makeRequest(urlSuffix: urlSuffix, method: "GET", completion: completion)
        }
    }
    
    func sendMessage(message: Message, completion: @escaping (Result<Message, Error>) -> Void) {
        let urlSuffix = "ai-chat"
        let requestBody: [String: Any] = [
            "text": message.text,
            "role": message.role
        ]
        Task {
            await coreApiClient.makeRequest(urlSuffix: urlSuffix, method: "POST", requestBody: requestBody, completion: completion)
        }
    }
    /// Fetch global stats for all users between two dates.
    func fetchGlobalStats(from fromDate: Date, to toDate: Date, completion: @escaping (Result<[GlobalStat], Error>) -> Void) {
        // Format dates as YYYY-MM-DD
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let fromString = formatter.string(from: fromDate)
        let toString = formatter.string(from: toDate)
        let urlSuffix = "global-stats?from=\(fromString)&to=\(toString)"
        Task {
            await coreApiClient.makeRequest(urlSuffix: urlSuffix, method: "GET", completion: completion)
        }
    }
    
}

enum NetworkError: Error {
    case invalidURL
    case unknownError
}
