//
//  File.swift
//  goTalkTestsTwo
//
    //--------------------------------------------------------------------------------------------------
//  Created by ksd8 on 2017-11-19.
//  Copyright © 2017 The Night Owls. All rights reserved.
//
import UIKit
extension registerController{
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
    
    //Function that checks if username is valid
    func isValidName(_ nameString: String) -> Bool{
        if(nameString == ""){
            return false
        } else {
            return true
        }
    }
    
    //Function that checks if password is valid
    func isValidPassword(_ passwordString: String) -> Bool{
        if(passwordString == ""){
            return false
        } else {
            return true
        }
    }
    //Function that checks if first name is valid
    func isValidFirstName (_ firstName: String) -> Bool{
        if(firstName == ""){
            return false
        } else {
            return true
        }
    }
    //Function that checks if last name is valid
    func isValidLastName (_ lastName: String) -> Bool{
        if(lastName == ""){
            return false
        } else {
            return true
        }
    }
    
    
}
