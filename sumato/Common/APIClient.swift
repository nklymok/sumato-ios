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
    
    func fetchProfile(forUserId userId: Int, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/profile/\(userId)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkError.unknownError))
                return
            }
            
            do {
                let profile = try JSONDecoder().decode(UserProfile.self, from: data)
                completion(.success(profile))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchProfileUpdate(forUserId userId: Int, profile: UserProfile, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/profile/\(userId)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // Prepare the request body
        let requestBody: [String: Any] = [
            "name": profile.name
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, error == nil else {
                                completion(.failure(error ?? NetworkError.unknownError))
                                return
                            }
                
                if httpResponse.statusCode == 200 {
                                completion(.success(()))
                            } else {
                                completion(.failure(NetworkError.unknownError))
                            }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchKanjis(forUserId userId: Int, isReview: Bool, completion: @escaping (Result<LessonResponse, Error>) -> Void) {
        let urlSuffix = isReview ? "/review" : "/study"
        guard let url = URL(string: "http://localhost:8080/api/kanji/\(userId)" + urlSuffix) else {
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
