//
//  aboutPageTestSyncController.swift
//  goTalk
//
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
//  Created by Yagnik Vadher on 11/26/17.
//  Copyright © 2017 The Night Owls. All rights reserved.
//

import UIKit
import Foundation


class aboutPageTestSyncController: UIViewController{
    
<<<<<<< HEAD
    // Button for Sync -- does not need to run code.
=======
    @IBOutlet weak var testBtn: UIButton!
    
>>>>>>> master
    @IBAction func syncBtn(_ sender: Any) {
        syncWithCloud()
    }
    
<<<<<<< HEAD
    // syncWithCloud connects with the webpage/database and uploads the user data (namely, saved favourites folder data).
=======
    //--------------------------------------------------------------------------------------------------
    
>>>>>>> master
    func syncWithCloud(){
        
        var savedData : Array<PhotoCategory>? = nil
        if let data = UserDefaults.standard.value(forKey:"mainData") as? Data {
            savedData = try? PropertyListDecoder().decode(Array<PhotoCategory>.self, from: data)
        }
        let encoder = JSONEncoder()
        let sendJSON = try! encoder.encode(savedData)
        
<<<<<<< HEAD
        // URL for the server API
=======
        //URL for the server API
>>>>>>> master
        guard let url = URL(string: "http://gotalkapp.herokuapp.com/api/saveConfig")
            else {
                print("Error: URL not found.")
                return
        }
        var request = URLRequest(url: url)
        
<<<<<<< HEAD
        // Make a post request object
=======
        //Make a post request object
>>>>>>> master
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = sendJSON
        
        let session = URLSession.shared
        
<<<<<<< HEAD
        // Start session to send post request
=======
        //Start session to send post request
>>>>>>> master
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(json)
                    
                    let item = json["result"] as! String
                    if (item == "Done"){
                        print ("Synced!")
<<<<<<< HEAD
                        self.displayAlertMessage(messageToDisplay: "Awesome! App is synced with database. Have a great day!")
                    }else {
                        print ("Not synced!")
=======
                        self.displayAlertMessage(messageToDisplay: "Awesome! App is synced with database!!Have a great day!")
                    }else {
                        print ("Not synced!!")
>>>>>>> master
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
