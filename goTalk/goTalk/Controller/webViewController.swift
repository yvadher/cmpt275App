//
//  webViewController.swift
//  goTalk
//
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
//  Created by Yagnik Vadher on 11/22/17.
//  Copyright © 2017 The Night Owls. All rights reserved.
//

import WebKit
class webViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    let spinWheel : UIActivityIndicatorView = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Add FAQs link
        let myURL = URL(string: "http://gotalkapp.herokuapp.com/")
        let myRequest = URLRequest(url: myURL!)
       // webView.navigationDelegate = (self as! WKNavigationDelegate)
        webView.load(myRequest)
        
        
        
        
    }
    
    // here show your indicator
    func webViewDidStartLoad(webView: UIWebView!){
        //Start spinning wheel after all check
        spinWheel.center = self.view.center
        spinWheel.hidesWhenStopped = true
        spinWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(spinWheel)
        spinWheel.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    // here hide it
    func webViewDidFinishLoad(webView: UIWebView!){
        spinWheel.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
