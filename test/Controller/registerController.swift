//
//  registerController.swift
//  test
//
//  Created by Yagnik Vadher on 11/5/17.
//  Copyright © 2017 ksd8. All rights reserved.
//

import UIKit

class registerController: UIViewController{
    
    
    @IBOutlet weak var _firstName: UITextField!
    @IBOutlet weak var _lastName: UITextField!
    @IBOutlet weak var _userName: UITextField!
    @IBOutlet weak var _userEmail: UITextField!
    @IBOutlet weak var _userPassword: UITextField!
    
    
    
    
    
    
    
    @IBAction func signUp(_ sender: Any) {
        
        let _userNameData: String = _userName.text!
        let _userEmailData: String = _userEmail.text!
        let _userPasswordData: String = _userPassword.text!
        
        
        let sendJSON = ["userName": _userNameData , "userEmail" : _userEmailData, "userPassword" : _userPasswordData]
        
        guard let url = URL(string: "http://gotalkapp.herokuapp.com/save") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: sendJSON, options: []) else { return }
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

