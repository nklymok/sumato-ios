//
//  sumatoApp.swift
//  sumato
//
//  Created by Nazarii Klymok on 19.04.2024.
//

import SwiftUI

@main
struct sumatoApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
