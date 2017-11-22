//
//  ForgotPassController.swift
//  Manages the Password Recovery page.
//
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
//  Created by Shawn Thai on 11/10/17.
//  Worked on by Shawn Thai and Yagnik Vadher.
//
//  Copyright © 2017 The Night Owls. All rights reserved.
//

import UIKit

class ForgotPassController: UIViewController {
    
    @IBOutlet weak var _userEmail: UITextField!
    
    
    @IBAction func continueAction(_ sender: Any) {
        
        let userEmail = _userEmail.text
        //MARK: Check the field is valid
        if (isValidEmailAddress( emailAddressString: _userEmail.text!)){
            
            //MARK: Send POST request
            let sendJSON = ["userEmail": _userEmail.text]
            
            // Connect to webpage
            guard let url = URL(string: "http://gotalkapp.herokuapp.com/api/email")
                else {
                    print("Error: URL not found.")
                    return
            }
            
            //Construct the post request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: sendJSON, options: [])
                else {
                    print("Error: Problem with JSON data.")
                    return
            }
            request.httpBody = httpBody
            print ("JSON being send : \(sendJSON) ")
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        print("Here is json: \(json)")
                        let result = json["result"] as! String
                        print (result)
                        
                        if (result == "sentEmail"){
                            print ("Came here! Matching JSON data has been found.")
                            
                            // Perform segue to go to Login page
                            OperationQueue.main.addOperation {
                                self.performSegue(withIdentifier: "forgetToDoneEmail", sender: self)
                            }
                            
                            
                        }else if (result == "notFound"){
                            
                            OperationQueue.main.addOperation {
                                let displayString = "Seems like user is not registered! Please try registering with the same email provided : \(userEmail ?? "Email" )"
                                self.displayAlertMessage(messageToDisplay: displayString)
                            }
                        }else {
                            print ("Something wrong happend!! \(result)")
                            OperationQueue.main.addOperation {
                                let displayString = "Something wrond happend!!"
                                self.displayAlertMessage(messageToDisplay: displayString)
                            }
                        }
                        
                    } catch {
                        print(error)
                    }
                }
                
                }.resume()
            
            //MARK: POST request ended
            
            
        }else {
            OperationQueue.main.addOperation {
                self.displayAlertMessage(messageToDisplay: "Email is Invalid!! Please try again :)")
            }
        }
    }
    
    
    // isValidEmailAddress takes in an input string (email address) and checks to see if it has the format XXXX@XXX.XXX
    // Returns false if contradiction is found, otherwise true.
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
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return returnValue
    }
    
    
    // displayAlertMessage takes in an input string (error message) and displays it to user via pop-up window.
    // The user may close the window by tapping the OK button that appears.
    func displayAlertMessage(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped.");
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
   
    
    
}
