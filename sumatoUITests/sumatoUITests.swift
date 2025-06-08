//
//  sumatoUITests.swift
//  sumatoUITests
//
//  Created by Nazarii Klymok on 24.05.2025.
//

import XCTest

final class sumatoUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
}
