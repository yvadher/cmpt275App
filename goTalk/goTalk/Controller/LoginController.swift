//
//  LoginController.swift
//  DEMOHSBC
//
//  Created by Ryan on 2017-10-26.
//  Copyright © 2017 Min.erva. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    //  mod. by Ryan on 2017-10-26.
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor=UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        return view
        
    }()
    
    //  mod. by Ryan on 2017-10-26.
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 221, g: 31, b: 38)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return button
    }()
    
    //  mod. by Ryan on 2017-10-26.
    let cardNumberTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    //  mod. by Ryan on 2017-10-26.
    let cardNumberSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints=false
        
        return view
    }()
    
    //  mod. by Ryan on 2017-10-26.
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        
        return tf
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hsbc-logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  mod. by Ryan on 2017-10-26.
        // all code below is for the login page
        //good and cool
        view.backgroundColor = UIColor(r: 232, g: 232, b: 232) // this is for the page color
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        
        setupInputsContainerView() //this is for the box anchors
        setupLoginRegisterButton() //this is for login button
        setupProfileImageView() //this is for prof pic
        
        // Do any additional setup after loading the view.
    }
    
    //  mod. by Ryan on 2017-10-26.
    func setupInputsContainerView(){
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive=true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive=true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 100).isActive=true
        
        inputsContainerView.addSubview(cardNumberTextField)
        cardNumberTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive=true
        cardNumberTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive=true
        cardNumberTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive=true
        cardNumberTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive=true
        
        inputsContainerView.addSubview(cardNumberSeparatorView)
        cardNumberSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive=true
        cardNumberSeparatorView.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor).isActive=true
        cardNumberSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive=true
        cardNumberSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive=true
        
        inputsContainerView.addSubview(passwordTextField)
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive=true
        passwordTextField.topAnchor.constraint(equalTo: cardNumberSeparatorView.bottomAnchor).isActive=true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive=true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive=true
        
    }
    
    //  mod. by Ryan on 2017-10-26.
    func setupLoginRegisterButton(){
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive=true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor ).isActive=true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive=true
        
    }
    
    //  mod. by Ryan on 2017-10-26.
    func setupProfileImageView(){
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        profileImageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive=true
        profileImageView.widthAnchor.constraint(equalToConstant: 120).isActive=true
        profileImageView.heightAnchor.constraint(equalToConstant: 120).isActive=true
        
    }
    
    /* //  mod. by Ryan on 2017-10-26.
     
     override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

