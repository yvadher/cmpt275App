//
//  fetchDataFromDatabase.swift
//  goTalk
//
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
//  Created by Yagnik Vadher on 11/26/17.
//  Copyright © 2017 The Night Owls. All rights reserved.
//

import UIKit

extension ViewController {
    
    func fetchDataFromDatabase(completion: @escaping () -> Void){
     
        //MARK: ------------------------Send a request STARTS ------------------------------------------
        
        let sendJSON : [String :String] = ["userEmail" : UserDefaults.standard.string(forKey: "userEmail")!]
        //URL for the server API
        guard let url = URL(string: "http://gotalkapp.herokuapp.com/api/getConfig")
            else {
                print("Error: URL not found.")
                return
        }
        var request = URLRequest(url: url)
        
        //Make a post request object
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Conver dictonory to JSON
        guard let httpBody = try? JSONSerialization.data(withJSONObject: sendJSON, options: [])
            else {
                print("Error: Problem with JSON data.")
                return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        
        //Start session to send post request
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    
                    let decoder = JSONDecoder();
                    self.photoCategory = try! decoder.decode([PhotoCategory].self, from: data)
                    
                    print (self.photoCategory)
                    self.favoritesButtons  =  PhotoCategory.fetchFavButtons(photoCat: self.photoCategory)
                    completion()
                    
                } catch {
                    print(error)
                    //testFlag = false
                }
            }
            }.resume()
        
        //MARK: -------------------------Send request END-----------------------------------------------
    }
    
}
