//
//  registerationTest.swift
//  goTalkTestsTwo
//
//  Created by Yagnik Vadher on 11/19/17.
//  Copyright © 2017 The Night Owls. All rights reserved.
//

import UIKit
import XCTest
@testable import goTalk

class registerationTest: XCTestCase {
    
    //Test registeration communication with server
    func testForRegistrationServerComm(){
        let register = registerController()
        let _userNameData = "testName"
        let _userEmailData = "testEmail"
        let _userPasswordData = "testPassword"
        let testJSON = ["userName": _userNameData , "userEmail" : _userEmailData, "userPassword" : _userPasswordData]
        let outputVal = register.sendToServer(testJSON)
        XCTAssertTrue(outputVal)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        let register = registerController()
        let _userNameData = "testName"
        let _userEmailData = "testEmail"
        let _userPasswordData = "testPassword"
        let testJSON = ["userName": _userNameData , "userEmail" : _userEmailData, "userPassword" : _userPasswordData]
        
        self.measure {
            register.sendToServer(testJSON)
            // Put the code you want to measure the time of here.
        }
    }
}
