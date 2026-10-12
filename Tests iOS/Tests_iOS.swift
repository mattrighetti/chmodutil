import XCTest

@MainActor
final class Tests_iOS: XCTestCase {
    func testToggleUpdatesTheMode() {
        let app = XCUIApplication()
        app.launch()
        let toggle = app.descendants(matching: .any).matching(identifier: "owner_x").firstMatch
        XCTAssertTrue(toggle.waitForExistence(timeout: 5))
        toggle.clickOrTap()
        XCTAssertEqual(app.staticTexts["octalResult"].label, "Octal permissions 655")
    }

    func testCommonModeUpdatesPermissions() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["preset600"].clickOrTap()
        XCTAssertEqual(app.staticTexts["octalResult"].label, "Octal permissions 600")
    }

    func testGuideCanBeOpenedAndNavigatedBack() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Permission guide"].clickOrTap()
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", "Basics")).firstMatch.waitForExistence(timeout: 5))
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", "Basics")).firstMatch.clickOrTap()
        XCTAssertTrue(app.staticTexts["Three people, three digits"].waitForExistence(timeout: 5))
        #if os(macOS)
        app.buttons["Back"].clickOrTap()
        app.buttons["Back"].clickOrTap()
        #else
        app.navigationBars.buttons.element(boundBy: 0).clickOrTap()
        app.navigationBars.buttons.element(boundBy: 0).clickOrTap()
        #endif
        XCTAssertTrue(app.staticTexts["octalResult"].exists)
    }
}

@MainActor
private extension XCUIElement {
    func clickOrTap() {
        #if os(macOS)
        click()
        #else
        tap()
        #endif
    }
}
