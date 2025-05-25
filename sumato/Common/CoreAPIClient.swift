//
//  CoreApiClient.swift
//  sumato
//
//  Created by Nazarii Klymok on 27.04.2024.
//

import Foundation
import Auth0

class CoreAPIClient {
    private let baseURL = "https://50bc-109-237-84-46.ngrok-free.app/api/student/"
    static let shared = CoreAPIClient()
    
    func makeRequest<T: Decodable>(urlSuffix: String, method: String, requestBody: [String: Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) async {
        guard let url = URL(string: baseURL + urlSuffix) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")


        let credentialsManager = CredentialsManager(authentication: Auth0.authentication())
        let accessToken: String
        do {
            let credentials = try await credentials()
            accessToken = credentials.accessToken
        } catch {
            credentialsManager.clear()
            NotificationCenter.default.post(name: .authenticationRequired, object: nil)
            completion(.failure(NetworkError.unauthorized))
            return
        }
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        if let requestBody = requestBody {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                request.httpBody = jsonData
            } catch {
                completion(.failure(error))
                return
            }
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                credentialsManager.clear()
                NotificationCenter.default.post(name: .authenticationRequired, object: nil)
                completion(.failure(NetworkError.unauthorized))
                return
            }
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkError.unknownError))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .custom { decoder -> Date in
                    let container = try decoder.singleValueContainer()
                    let dateString = try container.decode(String.self)

                    let formats = [
                        "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX", // with milliseconds
                        "yyyy-MM-dd'T'HH:mm:ssXXXXX"      // without milliseconds
                    ]

                    for format in formats {
                        let formatter = DateFormatter()
                        formatter.calendar = Calendar(identifier: .iso8601)
                        formatter.locale = Locale(identifier: "en_US_POSIX")
                        formatter.timeZone = TimeZone(secondsFromGMT: 0)
                        formatter.dateFormat = format

                        if let date = formatter.date(from: dateString) {
                            return date
                        }
                    }

                    throw DecodingError.dataCorruptedError(
                        in: container,
                        debugDescription: "Invalid date format: \(dateString)"
                    )
                }

                let decodedObject = try decoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    private func credentials() async throws -> Credentials {
        let credentialsManager = CredentialsManager(authentication: Auth0.authentication())
        
        return try await withCheckedThrowingContinuation { continuation in
            credentialsManager.credentials { result in
                switch result {
                case .success(let credentials):
                    continuation.resume(returning: credentials)
                    break
                    
                case .failure(let reason):
                    continuation.resume(throwing: reason)
                    break
                }
            }
        }
    }
    
    
}

extension Notification.Name {
    static let authenticationRequired = Notification.Name("authenticationRequired")
}
