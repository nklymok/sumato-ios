//
//  ApiClient.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    
    func fetchStats(forUserId userId: Int, completion: @escaping (Result<StatsResponse, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/kanji/\(userId)/stats") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkError.unknownError))
                return
            }
            
            do {
                let stats = try JSONDecoder().decode(StatsResponse.self, from: data)
                completion(.success(stats))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchStudyKanjis(forUserId userId: Int, completion: @escaping (Result<LessonResponse, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/kanji/\(userId)/study") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkError.unknownError))
                return
            }
            
            do {
                let stats = try JSONDecoder().decode(LessonResponse.self, from: data)
                completion(.success(stats))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchAnswerResult(forUserId userId: Int, reviewId: Int, userAnswer: String, completion: @escaping (Result<AnswerResultResponse, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/kanji/\(userId)/answer") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // Prepare the request body
        let requestBody: [String: Any] = [
            "reviewId": reviewId,
            "answer": userAnswer
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(error ?? NetworkError.unknownError))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(AnswerResultResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }

    
}

enum NetworkError: Error {
    case invalidURL
    case unknownError
}
