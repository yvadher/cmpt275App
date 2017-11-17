//
//  LoginTests.swift
//  goTalkTestsTwo
//
//  Created by ksd8 on 11/6/17.
//  Copyright © 2017 The Night Owls. All rights reserved.
//
import UIKit
import XCTest
@testable import goTalk

class LoginTests: XCTestCase {
    
    //var testEmail: String!
    var outputVal: Bool!
    
    override func setUp() {
        super.setUp()
        
    //var testEmail = "someone@gmail.com"
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
      //  testEmail = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLoginEmail(){
        let testEmail = "testEmail"
        let Login = LoginController()
        
        outputVal = Login.isValidEmailAddress(emailAddressString: testEmail)
        XCTAssertTrue(outputVal)
        
    }
    
    func testRegisterEmail(){
        let testEmail = "testEmail@gmail.com"
        let register = registerController()
        outputVal = register.isValidEmailAddress(emailAddressString: testEmail)
        XCTAssertTrue(outputVal)
    }
    
    func testEmailEmpty(){
        let testEmail = ""
        let register = registerController()
        outputVal = register.isEmpty(stringData: testEmail)
        XCTAssertTrue(outputVal)
    }
    
    func testNameEmpty(){
        let testName = ""
        let register = registerController()
        outputVal = register.isEmpty(stringData: testName)
        XCTAssertTrue(outputVal)
    }
    func testPasswordEmpty(){
        let testPwd = ""
        let register = registerController()
        outputVal = register.isEmpty(stringData: testPwd)
        XCTAssertTrue(outputVal)
    }
    
    
}
