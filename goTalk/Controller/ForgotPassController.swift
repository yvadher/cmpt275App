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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func goToLogin(_ sender: Any) {
        performSegue(withIdentifier: "toLoginRegisterSegue", sender: self)
    }
    
    
    
}
