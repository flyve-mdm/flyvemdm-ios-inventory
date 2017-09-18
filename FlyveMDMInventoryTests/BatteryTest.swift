//
//  BatteryTest.swift
//  FlyveMDMInventory
//
//  Created by Hector Rondon on 06/07/17.
//  Copyright © 2017 Teclib. All rights reserved.
//

import XCTest
import FlyveMDMInventory

class BatteryTest: XCTestCase {

    let battery = Battery()

    /// This method is called before the invocation of each test method in the class.
    override func setUp() {
        super.setUp()
    }

    /// This method is called after the invocation of each test method in the class.
    override func tearDown() {
        super.tearDown()
    }

    /// Get the state of the battery
    func testGetState() {
        XCTAssertNotNil(battery.state(), "Battery state not valid")
    }

    /// Get the level of the battery
    func testGetLevel() {
        XCTAssertNotNil(battery.level(), "Battery level not valid")
    }
}
