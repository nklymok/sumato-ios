//
//  Message.swift
//  sumato
//
//  Created by Nazarii Klymok on 01.05.2024.
//

import Foundation

struct Message: Hashable, Decodable {
    var id = UUID()
    var text: String
    var role: String
}
