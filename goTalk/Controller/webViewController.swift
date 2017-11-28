//
//  webViewController.swift
//  goTalk
//
//  Created by Yagnik Vadher on 11/22/17.
//  Copyright © 2017 The Night Owls. All rights reserved.
//

import WebKit
class webViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    let speenWheel : UIActivityIndicatorView = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Add FAQs link
        let myURL = URL(string: "http://gotalkapp.herokuapp.com/")
        let myRequest = URLRequest(url: myURL!)
        webView.navigationDelegate = (self as! WKNavigationDelegate)
        webView.load(myRequest)
        
        
        
        
    }
    
    // here show your indicator
    func webViewDidStartLoad(webView: UIWebView!){
        //Start spinning wheel after all check
        speenWheel.center = self.view.center
        speenWheel.hidesWhenStopped = true
        speenWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(speenWheel)
        speenWheel.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    // here hide it
    func webViewDidFinishLoad(webView: UIWebView!){
        speenWheel.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
