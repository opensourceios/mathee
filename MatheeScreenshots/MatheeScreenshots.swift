//
//  MatheeScreenshots.swift
//  MatheeScreenshots
//
//  Created by Daniel Springer on 5/20/22.
//  Copyright © 2024 Daniel Springer. All rights reserved.
//

import XCTest

class MatheeScreenshots: XCTestCase {

    // xcodebuild -testLanguage en -scheme Mathee -project ./Mathee.xcodeproj
    // -derivedDataPath '/tmp/MatheeDerivedData/' -destination
    // "platform=iOS Simulator,name=iPhone 13 Pro Max" build test
    // https://blog.winsmith.de/english/ios/2020/04/14/xcuitest-screenshots.html

    var app: XCUIApplication!

    let aList = ["Guess It", "Spot It", "Lower or Higher"]


    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()

        // We send a command line argument to our app,
        // to enable it to reset its state
        app.launchArguments.append("--matheeScreenshots")
    }


    func anAction(word: String) {
        let tablesQuery = app.tables
        let aThing = tablesQuery.cells.staticTexts[word]
        XCTAssertTrue(aThing.waitForExistence(timeout: 5))
        aThing.tap()
        switch word {
            case "Guess It":
                XCTAssertTrue(app.buttons["OK"].firstMatch.waitForExistence(timeout: 5))
                takeScreenshot(named: "4-Guess-it-think")
                app.buttons["OK"].firstMatch.tap()
                takeScreenshot(named: "5-Guess-it-multiply")
                app.buttons["OK"].firstMatch.tap()
                app.buttons["Even"].firstMatch.tap()
                app.buttons["OK"].firstMatch.tap() // /2 1
                app.buttons["OK"].firstMatch.tap() // x3 2
                app.buttons["Odd"].firstMatch.tap()
                app.buttons["OK"].firstMatch.tap() // add 1
                app.buttons["OK"].firstMatch.tap() // /2 2
                app.textFields.firstMatch.typeText("6")
                app.buttons["Guess my number"].firstMatch.tap()
                takeScreenshot(named: "6-Guess-it-result")
                app.buttons["Done"].firstMatch.tap()
            case "Spot It":
                XCTAssertTrue(app.buttons["OK"].firstMatch.waitForExistence(timeout: 5))
                app.buttons["OK"].firstMatch.tap()
                app.buttons["Yes"].firstMatch.tap()
                app.buttons["Yes"].firstMatch.tap()
                app.buttons["Yes"].firstMatch.tap()
                takeScreenshot(named: "1-Spot-it")
                app.buttons["Mathee"].firstMatch.tap()
            case "Lower or Higher":
                XCTAssertTrue(app.buttons["OK"].firstMatch.waitForExistence(timeout: 5))
                app.buttons["OK"].firstMatch.tap()
                app.buttons["Lower"].firstMatch.tap()
                app.buttons["Lower"].firstMatch.tap()
                takeScreenshot(named: "2-higher-lower")
                app.buttons["Higher"].firstMatch.tap()
                app.buttons["Correct"].firstMatch.tap()
                takeScreenshot(named: "2-higher-lower-guessed")
                app.buttons["Mathee"].firstMatch.tap()
            default:
                fatalError()
        }
    }


    func testMakeScreenshots() {
        app.launch()

        // Home
        takeScreenshot(named: "7-Home")

        for aItem in aList {
            anAction(word: aItem)
        }

    }


    func takeScreenshot(named name: String) {
        // Take the screenshot
        let fullScreenshot = XCUIScreen.main.screenshot()

        // Create a new attachment to save our screenshot
        // and give it a name consisting of the "named"
        // parameter and the device name, so we can find
        // it later.
        let screenshotAttachment = XCTAttachment(
            uniformTypeIdentifier: "public.png",
            name: "Screenshot-\(UIDevice.current.name)-\(name).png",
            payload: fullScreenshot.pngRepresentation,
            userInfo: nil)

        // Usually Xcode will delete attachments after
        // the test has run; we don't want that!
        screenshotAttachment.lifetime = .keepAlways

        // Add the attachment to the test log,
        // so we can retrieve it later
        add(screenshotAttachment)
    }

}
