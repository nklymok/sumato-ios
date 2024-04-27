//
//  UserProfileViewModel.swift
//  sumato
//
//  Created by Nazarii Klymok on 27.04.2024.
//

import SwiftUI

class UserProfileViewModel: ObservableObject {
    @Published var dangoCount: Int = 0
    @Published var name: String = ""
    @Published var level: Int = 5
    @Published var publicId: String = ""

    
    func fetchData(userId: Int?) {
        guard let userId = userId else {
            print("User ID is nil")
            return
        }

        APIClient.shared.fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile):
                DispatchQueue.main.async {
                    self.dangoCount = profile.dangoCount
                    self.name = profile.name
                    self.level = profile.level
                    self.publicId = profile.publicId
                }
            case .failure(let error):
                print("Error fetching stats: \(error)")
            }
        }
    }
    
    func updateData(userId: Int?) {
        guard let userId = userId else {
            print("User ID is nil")
            return
        }

        let userProfile = UserProfile(id: userId, dangoCount: dangoCount, name: name, level: level, publicId: publicId)
        APIClient.shared.fetchProfileUpdate(forUserId: userId, profile: userProfile) { result in
            switch result {
            case .success(let profile):
                print("Successfully updated profile!")
            case .failure(let error):
                print("Error fetching profile: \(error)")
            }
        }
    }
}
