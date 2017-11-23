//
//  speakWords.swift
//  goTalk
//
//  Created by Yagnik Vadher on 2017-11-17.
//  Copyright © 2017 The Night Owls. All rights reserved.
//

import UIKit
import AVFoundation

//Speak function that speaks out string that is being passed as argument
extension ViewController {
    func speakLine(line: String){
        let speechSynthesizer = AVSpeechSynthesizer()
        let speechUtterance = AVSpeechUtterance(string: line)
        
        speechUtterance.rate = 0.45
        speechSynthesizer.speak(speechUtterance)
    }
    
    // this is how you can join the string
    //let lineToSpeak: String = clickedPhotos.joined(separator: " ")
    
    
    func correctGrammer(_ sendJSON: String) {
        
        //URL for the server API
        var testFlag = true
        guard let url = URL(string: "http://textgears.com/api")
            else {
                print("Error: URL not found.")
                return
        }
        var request = URLRequest(url: url)
        
        //Make a post request object
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(json)
                    
                    let item = json["result"] as! String
                    //You can get items like item[0].bad...
                    //MARK: Form a correct string based on the result recived from the api
                    
                    
                    
                    
                    //Once done getting string we will call it a speakFunction
                    //End
                } catch {
                    print(error)
                    testFlag = false
                }
            }
            
            }.resume()
    }
    
}


