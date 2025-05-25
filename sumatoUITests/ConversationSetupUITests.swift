import XCTest

final class ConversationSetupUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        // Use launch argument to bypass login and go straight to app content
        app.launchArguments.append("-ui-testing")
        app.launch()
    }

    func testConversationSetupFieldsAndStartButton() throws {
        // Navigate to the Realtime tab where ConversationSetupView is presented
        app.tabBars.buttons["Realtime"].tap()

        let userRoleField = app.textFields["userRoleTextField"]
        XCTAssertTrue(userRoleField.waitForExistence(timeout: 2))

        let aiRoleField = app.textFields["aiRoleTextField"]
        XCTAssertTrue(aiRoleField.exists)

        let situationField = app.textFields["situationTextField"]
        XCTAssertTrue(situationField.exists)

        let startButton = app.buttons["startConversationButton"]
        XCTAssertTrue(startButton.exists)
        XCTAssertFalse(startButton.isEnabled)

        userRoleField.tap()
        userRoleField.typeText("Student")

        aiRoleField.tap()
        aiRoleField.typeText("Teacher")

        situationField.tap()
        situationField.typeText("Ordering coffee")

        XCTAssertTrue(startButton.isEnabled)
    }
}