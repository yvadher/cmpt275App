//
//  registerController.swift
//  Manages the Registration Screen functionality and connection with database.
//
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
//  Created by Yagnik Vadher on 11/5/17.
//  Worked on by Yagnik Vadher and Shawn Thai.
//
//  11/06/2017: Code formatting. (Shawn Thai)
//              Added error case if empty data was inputted by user. (Shawn Thai)
//
//  Copyright © 2017 ksd8. All rights reserved.
//

import UIKit

class registerController: UIViewController{
    
    @IBOutlet weak var _firstName: UITextField!
    @IBOutlet weak var _lastName: UITextField!
    @IBOutlet weak var _userName: UITextField!
    @IBOutlet weak var _userEmail: UITextField!
    @IBOutlet weak var _userPassword: UITextField!

    // Takes in user data, which is sent to the database for user registration.
    // Makes a request at database URL and adds new JSON data.
    @IBAction func signUp(_ sender: Any) {
        
        let _userNameData: String = _userName.text!
        let _userEmailData: String = _userEmail.text!
        let _userPasswordData: String = _userPassword.text!
        
        // Check if empty
        if (_userNameData == "" || _userEmailData == "" || _userPasswordData == ""){
            print("Error: All fields required")
            return
        }
        
        let sendJSON = ["userName": _userNameData , "userEmail" : _userEmailData, "userPassword" : _userPasswordData]
        
        guard let url = URL(string: "http://gotalkapp.herokuapp.com/save")
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
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
          
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            OperationQueue.main.addOperation {
                self.performSegue(withIdentifier: "mainSegueRegister", sender: self)
            }
            }.resume()
    }
}

