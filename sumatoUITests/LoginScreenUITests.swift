import XCTest

final class LoginScreenUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    func testLoginButtonsExist() throws {
        app.launch()
        let appleButton = app.buttons["apple_login_button"]
        XCTAssertTrue(appleButton.waitForExistence(timeout: 2))

        let googleButton = app.buttons["google_login_button"]
        XCTAssertTrue(googleButton.exists)
    }

    func testAutoLoginWithStubUserSkipsLoginScreen() throws {
        app.launchArguments.append("-ui-testing")
        app.launch()
        XCTAssertTrue(app.tabBars.buttons["Kanji"].waitForExistence(timeout: 2))
    }
}