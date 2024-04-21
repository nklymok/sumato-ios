//
//  Kanji.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import Foundation

struct Kanji: Decodable {
    let value: String
    let onyomi: String
    let kunyomi: String
    let meaning: String
    let koohiiStory: String
    let grade: String
    let frequency: Int
}
