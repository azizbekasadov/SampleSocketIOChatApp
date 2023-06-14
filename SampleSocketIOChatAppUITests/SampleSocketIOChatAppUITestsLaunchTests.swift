//
//  SampleSocketIOChatAppUITestsLaunchTests.swift
//  SampleSocketIOChatAppUITests
//
//  Created by Azizbek Asadov on 14/06/23.
//

import XCTest

final class SampleSocketIOChatAppUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
