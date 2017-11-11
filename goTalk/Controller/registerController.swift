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
    @IBOutlet weak var letMeLogInButton: UIButton!
    
    
    // Takes in user data, which is sent to the database for user registration.
    // Makes a request at database URL and adds new JSON data.
    @IBAction func signUp(_ sender: Any) {
        
        let _userNameData: String = _userName.text!
        let _userEmailData: String = _userEmail.text!
        let _userPasswordData: String = _userPassword.text!
        
        
        let checkName = isEmpty(stringData: _userNameData)
        let checEmail = isEmpty(stringData: _userEmailData)
        let checkPwd = isEmpty(stringData: _userPasswordData)
        
        
        // Check if email address
        if (checEmail || checkPwd || checkName){
            displayAlertMessage(messageToDisplay: "Username, useremail and userpassword can not be empty!! Please try again :)")
        }
            let isEmailAddressValid = isValidEmailAddress(emailAddressString: _userEmailData)
        
        if isEmailAddressValid
        {
            print("Email address is valid")
        } else {
            print("Email address is not valid")
            displayAlertMessage(messageToDisplay: "Email address is not valid")
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
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(json)
                    
                    let item = json["result"] as! String
                    
                    if (item == "exist"){
                        OperationQueue.main.addOperation {
                            self.displayAlertMessage(messageToDisplay: "User email is registered!! Please try again with new email :)")
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
    
    
    @IBAction func goToLogin(_ sender: Any) {
        performSegue(withIdentifier: "toLoginRegisterSegue", sender: self)
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
     func isEmpty(stringData : String) -> Bool{
        if (stringData == ""){
            return true
        }else
        {
            return false
        }
    }
}

