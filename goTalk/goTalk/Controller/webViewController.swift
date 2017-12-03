//
//  webViewController.swift
//  goTalk
//
<<<<<<< HEAD
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
=======
>>>>>>> master
//  Created by Yagnik Vadher on 11/22/17.
//  Copyright © 2017 The Night Owls. All rights reserved.
//

import WebKit
class webViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
<<<<<<< HEAD
    let spinWheel : UIActivityIndicatorView = UIActivityIndicatorView()
=======
    let speenWheel : UIActivityIndicatorView = UIActivityIndicatorView()
>>>>>>> master
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
<<<<<<< HEAD
        // Add FAQs link
        let myURL = URL(string: "http://gotalkapp.herokuapp.com/")
        let myRequest = URLRequest(url: myURL!)
       // webView.navigationDelegate = (self as! WKNavigationDelegate)
        webView.load(myRequest)
        
=======
        //Add FAQs link
        let myURL = URL(string: "http://gotalkapp.herokuapp.com/")
        let myRequest = URLRequest(url: myURL!)
        webView.navigationDelegate = (self as! WKNavigationDelegate)
        webView.load(myRequest)
        
        
        
        
>>>>>>> master
    }
    
    // here show your indicator
    func webViewDidStartLoad(webView: UIWebView!){
        //Start spinning wheel after all check
<<<<<<< HEAD
        spinWheel.center = self.view.center
        spinWheel.hidesWhenStopped = true
        spinWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(spinWheel)
        spinWheel.startAnimating()
=======
        speenWheel.center = self.view.center
        speenWheel.hidesWhenStopped = true
        speenWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(speenWheel)
        speenWheel.startAnimating()
>>>>>>> master
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    // here hide it
    func webViewDidFinishLoad(webView: UIWebView!){
<<<<<<< HEAD
        spinWheel.stopAnimating()
=======
        speenWheel.stopAnimating()
>>>>>>> master
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
