import XCTest

final class LoginScreenUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testLoginButtonsExist() throws {
        let appleButton = app.buttons["apple_login_button"]
        XCTAssertTrue(appleButton.waitForExistence(timeout: 2))

        let googleButton = app.buttons["google_login_button"]
        XCTAssertTrue(googleButton.exists)
    }
}