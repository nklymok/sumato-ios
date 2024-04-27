//
//  UserProfileDTO.swift
//  sumato
//
//  Created by Nazarii Klymok on 27.04.2024.
//

import Foundation

struct UserProfile: Decodable, Hashable {
    let id: Int
    let dangoCount: Int
    let name: String
    let level: Int
    let publicId: String
}
