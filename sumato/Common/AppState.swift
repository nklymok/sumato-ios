//
//  AppState.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var showPoints = true
    @Published var kanjiIndex: Int?
    @Published var totalKanji: Int?
    @Published var userId: Int?
    @Published var path: NavigationPath = NavigationPath()
}
