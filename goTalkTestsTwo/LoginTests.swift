
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
    
    
    
    func testLoginEmail(){
        let testEmail = "testEmail@email.com"
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
    
    
    //Test if registration username is an empty string
    func testForEmptyName(){
        let register = registerController()
        let testName = ""
        let outputVal = register.isValidName(testName)
        XCTAssertFalse(outputVal)
    }
    
    //Test if registration password is an empty string
    func testForEmptyPassword(){
        let testPwd = ""
        let register = registerController()
        let outputVal = register.isValidPassword(testPwd)
        XCTAssertFalse(outputVal)
    }
    
    
    //Test if first name is valid
    func testForValidFirstName(){
        let register = registerController()
        let testName = "Test"
        outputVal = register.isValidFirstName(testName)
        XCTAssertTrue(outputVal)
    }
    
    //Test if last name is valid
    func testForValidLastName(){
        let register = registerController()
        let testName = "Test"
        outputVal = register.isValidLastName(testName)
        XCTAssertTrue(outputVal)
    }
    
   
    
}



