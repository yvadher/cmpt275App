//
//  registerController.swift
//  Manages the Registration Screen functionality and connection with database.
//
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
//  Created by Yagnik Vadher on 11/5/17.
//  Worked on by Yagnik Vadher and Shawn Thai.
//
//  11/06/2017: Code formatting. (Shawn Thai)
//              Added error case if empty data was inputted by user. (Yagnik Vadher)
//              Added error case if email address of invalid format was inputted by user. (Yagnik Vadher)
//  11/10/2017: Code formatting, renaming of variables, comments, and rewriting of error messages. (Shawn Thai)
//
//  Copyright © 2017 ksd8. All rights reserved.
//

import UIKit

class registerController: UIViewController {
    
    //outlet for all fields
    @IBOutlet weak var _firstName: UITextField!
    @IBOutlet weak var _lastName: UITextField!
    @IBOutlet weak var _userName: UITextField!
    @IBOutlet weak var _userEmail: UITextField!
    @IBOutlet weak var _userPassword: UITextField!
    @IBOutlet weak var letMeLogInButton: UIButton!
    
    
    //goToLogin button to go back to login view controller
    @IBAction func goToLogin(_ sender: Any) {
        performSegue(withIdentifier: "toLoginRegisterSegue", sender: self)
    }
    
    
    // Takes in user data, which is sent to the database for user registration.
    // Makes a request at database URL and adds the new JSON data.
    @IBAction func signUp(_ sender: Any) {
        
        let _userNameData: String = _userName.text!
        let _userEmailData: String = _userEmail.text!
        let _userPasswordData: String = _userPassword.text!
        let _firstNameData: String = _firstName.text!
        let _lastNameData: String = _lastName.text!
        
        // Check if empty data
        
        if (_userNameData == "" || _userEmailData == "" || _userPasswordData == "") {
            displayAlertMessage(messageToDisplay: "Please fill in your email and password and try again.")
            return
        }
        
        //Check if firsname is empty
        if isValidFirstName(_firstNameData){
            print("First name is valid.")
        } else {
            print("First name is empty")
        }
        
        //Check if lastname is empty
        if isValidLastName(_lastNameData){
            print("Last name is valid.")
        } else {
            print("Last name is empty")
        }
        
        
        //Check if password is empty
        if isValidPassword(_userPasswordData){
            print("Password is valid.")
        } else {
            print("Password is empty.")
        }
        
        //Check if name is empty
        if isValidName(_userNameData){
            print("Name is valid.")
        } else {
            print("Name is empty.")
        }
        
        // Check if email address is valid format
        if isValidEmailAddress(emailAddressString: _userEmailData)
        {
            print("Email address is valid.")
        } else {
            print("Email address is not valid.")
            displayAlertMessage(messageToDisplay: "Email address is not valid.")
        }
        
        //Prepare JSON data to post the request
        let inputJSON = ["userName": _userNameData , "userEmail" : _userEmailData, "userPassword" : _userPasswordData]
        
        sendToServer(inputJSON)
        
    }
    
    
    func sendToServer(_ sendJSON: [String: String]) -> Bool{
        //URL for the server API
        var testFlag = true
        guard let url = URL(string: "http://gotalkapp.herokuapp.com/save")
            else {
                print("Error: URL not found.")
                return false
        }
        var request = URLRequest(url: url)
        
        //Make a post request object
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: sendJSON, options: [])
            else {
                print("Error: Problem with JSON data.")
                return false
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        
        //Start session to send post request
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(json)
                    
                    let item = json["result"] as! String
                    
                    
                    if (item == "exist"){
                        
                        // json file with user name exits on server than display message
                        OperationQueue.main.addOperation {
                            self.displayAlertMessage(messageToDisplay: "Email has already been registered. Please try again with a different email.")
                            self.letMeLogInButton.isHidden = false
                            testFlag = false
                        }
                    }else {
                        
                        //Save user logged in(true) information to the userDefaults
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        UserDefaults.standard.synchronize()
                        
                        //Perform segue to go to the main page
                        OperationQueue.main.addOperation {
                            self.performSegue(withIdentifier: "mainSegueRegister", sender: self)
                        }
                        
                    }
                    
                } catch {
                    print(error)
                    testFlag = false
                }
            }
            
            }.resume()
        return testFlag
    }
    
    
}


