//
//  aboutPageTestSyncController.swift
//  goTalk
//
//  Created by Yagnik Vadher on 11/26/17.
//  Copyright © 2017 The Night Owls. All rights reserved.
//

import UIKit
import Foundation


class aboutPageTestSyncController: UIViewController{
    
    @IBOutlet weak var testBtn: UIButton!
    
    @IBAction func syncBtn(_ sender: Any) {
        syncWithCloud()
    }
    
    func syncWithCloud(){
        
        var savedData : Array<PhotoCategory>? = nil
        if let data = UserDefaults.standard.value(forKey:"mainData") as? Data {
            savedData = try? PropertyListDecoder().decode(Array<PhotoCategory>.self, from: data)
        }
        let encoder = JSONEncoder()
        let sendJSON = try! encoder.encode(savedData)
        
        //URL for the server API
        guard let url = URL(string: "http://gotalkapp.herokuapp.com/api/saveConfig")
            else {
                print("Error: URL not found.")
                return
        }
        var request = URLRequest(url: url)
        
        //Make a post request object
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = sendJSON
        
        let session = URLSession.shared
        
        //Start session to send post request
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(json)
                    
                    let item = json["result"] as! String
                    if (item == "true"){
                        print ("Synced!")
                        self.displayAlertMessage(messageToDisplay: "Awesome! App is synced with database!!Have a great day!")
                    }else {
                        print ("Not synced!!")
                    }
                    
                } catch {
                    print(error)
                    //testFlag = false
                }
            }
        }.resume()
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
