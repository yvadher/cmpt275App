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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Add FAQs link
        let myURL = URL(string: "http://gotalkapp.herokuapp.com/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
}
