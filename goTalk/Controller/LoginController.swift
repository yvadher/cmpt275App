//
//  LoginController.swift
//  Manages the Login Screen functionality and connection with database.
//
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
//  Created by Yagnik Vadher on 11/3/17.
//  Worked on by Yagnik Vadher and Shawn Thai
//
//  11/06/2017: Code formatting. (Shawn Thai)
//              Added error case if empty data was inputted by user. (Shawn Thai)
//
//  Copyright © 2017 ksd8. All rights reserved.
//

import UIKit

class LoginController: UIViewController{
    
    @IBOutlet weak var _userName: UITextField!
    @IBOutlet weak var _userPwd: UITextField!
    @IBOutlet weak var forgotPwdButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    // Takes in user data, which is sent to the database for user verification.
    // Makes a request at database URL for JSON data.
    @IBAction func LogIn(_ sender: Any) {
        let userNameData: String = _userName.text!
        let userPwdData: String = _userPwd.text!
        
        // Check if empty
        if (userNameData == "" || userPwdData == ""){
            print("Error: All fields required")
            return
        }
        
        let sendJSON = ["userEmail": userNameData , "userPassword" : userPwdData]
        
        guard let url = URL(string: "http://gotalkapp.herokuapp.com/find")
            else {
                print("Error: URL not found")
                return
            }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: sendJSON, options: [])
            else {
                print("Error: Problem with JSON data")
                return
            }
        request.httpBody = httpBody
        
        loginButton.isEnabled = false
        print (sendJSON)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print("Here is json: \(json)")
                    let item = json["result"] as! String
                    
                    print (item)
                    if (item == "true"){
                        print ("Came here !!!!!")
                        OperationQueue.main.addOperation {
                            self.performSegue(withIdentifier: "mainPageSegue", sender: self)
                        }
                    }else {
                        print ("Error: Incorrect password")
                    }
                    
                    // Perform segue to go to main page
                } catch {
                    print(error)
                }
            }

            }.resume()
        self.loginButton.isEnabled = true
    }
    
    
    @IBAction func goToRegister(_ sender: Any) {
        OperationQueue.main.addOperation {
            self.performSegue(withIdentifier: "registerSegue", sender: self)
        }
    }
    
    
    @IBAction func forgotPwd(_ sender: Any) {
    }
}

