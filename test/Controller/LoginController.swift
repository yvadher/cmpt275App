//
//  LoginController.swift
//  test
//
//  Created by Yagnik Vadher on 11/3/17.
//  Copyright © 2017 ksd8. All rights reserved.
//

import UIKit

class LoginController: UIViewController{
    


    
    @IBOutlet weak var _userName: UITextField!
    
    @IBOutlet weak var _userPwd: UITextField!
    
    
    @IBOutlet weak var forgotPwdButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func LogIn(_ sender: Any) {
        let userNameData: String = _userName.text!
        let userPwdData: String = _userPwd.text!
        
        let sendJSON = ["userEmail": userNameData , "userPassword" : userPwdData]
        
        guard let url = URL(string: "http://gotalkapp.herokuapp.com/find") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: sendJSON, options: []) else { return }
        request.httpBody = httpBody
        
        loginButton.isEnabled = false
        
        print (sendJSON)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                //print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    
                    guard let item = json as? [String: Any],
                        let person = item["result"] as? [String: Any] else {
                            return
                    }

                    print ("Here is the data: \(person)")
                    
                    
                    
                    //Perfomr seguve to go to main page
                } catch {
                    print(error)
                }
            }
            
            }.resume()
        self.loginButton.isEnabled = true
    }
    
    
    @IBAction func goToRegister(_ sender: Any) {
    }
    
    
    @IBAction func forgotPwd(_ sender: Any) {
    }
}
