//
//  AppState.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var showPoints = true
    @Published var userId: Int?
}
