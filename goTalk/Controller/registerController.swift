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
    
    @IBOutlet weak var _firstName: UITextField!
    @IBOutlet weak var _lastName: UITextField!
    @IBOutlet weak var _userName: UITextField!
    @IBOutlet weak var _userEmail: UITextField!
    @IBOutlet weak var _userPassword: UITextField!
    @IBOutlet weak var letMeLogInButton: UIButton!
    
    @IBAction func goToLogin(_ sender: Any) {
        performSegue(withIdentifier: "toLoginRegisterSegue", sender: self)
    }
    
    
    // Takes in user data, which is sent to the database for user registration.
    // Makes a request at database URL and adds the new JSON data.
    @IBAction func signUp(_ sender: Any) {
        
        let _userNameData: String = _userName.text!
        let _userEmailData: String = _userEmail.text!
        let _userPasswordData: String = _userPassword.text!
        
        // Check if empty data
        if (_userNameData == "" || _userEmailData == "" || _userPasswordData == "") {
            displayAlertMessage(messageToDisplay: "Please fill in your email and password and try again.")
            return
        }
        
        // Check if email address is valid format
        if isValidEmailAddress(emailAddressString: _userEmailData)
        {
            print("Email address is valid.")
        } else {
            print("Email address is not valid.")
            displayAlertMessage(messageToDisplay: "Email address is not valid.")
        }
        
        let sendJSON = ["userName": _userNameData , "userEmail" : _userEmailData, "userPassword" : _userPasswordData]
        
        guard let url = URL(string: "http://gotalkapp.herokuapp.com/save")
            else {
                print("Error: URL not found.")
                return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: sendJSON, options: [])
            else {
                print("Error: Problem with JSON data.")
                return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(json)
                    
                    let item = json["result"] as! String
                    
                    if (item == "exist"){
                        OperationQueue.main.addOperation {
                            self.displayAlertMessage(messageToDisplay: "Email has already been registered. Please try again with a different email.")
                            self.letMeLogInButton.isHidden = false
                        }
                        
                        
                    }else {
                        print (item)
                        OperationQueue.main.addOperation {
                            self.performSegue(withIdentifier: "mainSegueRegister", sender: self)
                        }
                        
                    }
                    
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    
    // isValidEmailAddress checks if the input (email address) is of valid format, ie. contains XXXXX@XXX.XXX
    // Returns true if valid, otherwise false.
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                returnValue = false
            }
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return returnValue
    }
    
    
    // displayAlertMessage takes in an input string (error message) and displays it to user via pop-up window.
    // The pop-up window will have an OK button, which when tapped, will close the window.
    func displayAlertMessage(messageToDisplay: String) {
        
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            print("OK button tapped.");
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
}
