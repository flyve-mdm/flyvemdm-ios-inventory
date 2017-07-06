//
//  Carrier.swift
//  FlyveMDMInventory
//
//  Created by Hector Rondon on 06/07/17.
//  Copyright © 2017 Teclib. All rights reserved.
//

import XCTest
import FlyveMDMInventory

class CarrierTest: XCTestCase {
    
    let carrier = Carrier()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
#if TARGET_IPHONE
    func testGetRadio() {
        XCTAssertNotNil(carrier.radio(), "radio access technology not valid")
    }
    
    func testGetName() {
        XCTAssertNotNil(carrier.name(), "Carrier name not valid")
    }
    
    func testGetCountryCode() {
        XCTAssertNotNil(carrier.countryCode(), "Carrier country code not valid")
    }
    
    func testGetMobileNetworkCode() {
        XCTAssertNotNil(carrier.mobileNetworkCode(), "Mobile network code not valid")
    }
    
    func testGetIsAllowsVOIP() {
        XCTAssertNotNil(carrier.isAllowsVOIP(), "Carrier Allows VOIP not valid")
    }
#endif
}
