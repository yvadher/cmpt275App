//
//  SideMenuViewController.swift
//  goTalk
//
//  Created by Fahd CHAUDHRY on 2017-11-27.
//  Copyright © 2017 The Night Owls. All rights reserved.
//

import UIKit

class sideMenuController: UITableViewController {
    
    @IBOutlet var sideMenu: UITableView!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
        // Navigate to different pages from the Side Menu
        switch indexPath.row {
            
            // Sync
            case 1:
                syncWithCloud()
                break
            
            // Settings
            //case 2:
            
            // Help
            //case 3:
            
            // About
            //case 4:
            
            // Log Out
            case 5:
                //Save user logged in(true) information to the userDefaults
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                UserDefaults.standard.synchronize()
                OperationQueue.main.addOperation {
                    self.performSegue(withIdentifier: "sideBarToLogIn", sender: self)
                }
                print("Log Out Executed")
                break
            
        default: break
        }
    }
    
    //--------------------------------------------------------------------------------------------------
    
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
                    if (item == "Done"){
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

