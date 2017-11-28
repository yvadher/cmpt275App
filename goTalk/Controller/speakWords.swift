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
    
    
    func correctGrammer(_ sendJSON: String, completion: @escaping (Any?) -> Void ) -> String{
        var inputSentencePlus = self.clickedPhotos.joined(separator: "+")
        var inputSentence = self.clickedPhotos.joined(separator: " ")
        print("Print 1")
        //URL for the server API
        let apiKey = "&key=CEjByKpLU5oTE6qg"
        let apiURL = "https://api.textgears.com/check.php?text="
        print(sendJSON)
        let joinedURL = apiURL + inputSentencePlus + apiKey
        print(joinedURL)
        var testFlag = true
        guard let url = URL(string: joinedURL)
            else {
                print("Error: URL not found.")
                return "error"
        }
        
        let session = URLSession.shared
        
        //Start session to send post request
        session.dataTask(with: url) { (data, response, error) in
            
            //var testString: String = "This is a test String"
            //var badWord: String = ""
            var offset: Int = 0
            var badLength: Int = 0
            var betterWord: String = ""
            var removedChar: Character
            print("Print 2")
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(json)
                    
                    
                    let result = json["score"] as! Int
                    if(result == 100){
                        testFlag = false;
                        print("RESULT LESS THAN 100")
                        return
                    }
                    
                    print("Print 3")
                    
                    let errors = json["errors"] as! [[String: Any]]
                    for error in errors{
                        offset = error["offset"] as! Int
                        badLength = error["length"] as! Int
                        let suggestions = error["better"] as! [String]
                        betterWord = suggestions[0]
                        let index = inputSentence.index(inputSentence.startIndex, offsetBy: offset)   //.advanceBy(offset)
                        for _ in 1...badLength {
                            removedChar = inputSentence.remove(at: index)
                        }
                        
                        print("Input Sentence in Do:", inputSentence)
                        let betterWordRev = String(betterWord.characters.reversed())
                        for char in 0...betterWord.count-1{
                            var indexCount = 0
                            print(char)
                            let index2 = betterWord.index(betterWord.startIndex, offsetBy: char + indexCount)
                            print(betterWord[index2])
                            inputSentence.insert(betterWordRev[index2], at: inputSentence.index(inputSentence.startIndex, offsetBy: offset + indexCount))
                            indexCount += 1
                            
                        }
                        print("Input Sentence is:",inputSentence)
                        completion(inputSentence)
                    }
                    
                } //end of do block
                catch{
                    print(error)
                    testFlag = false
                }
            } // end of if let data = data
            }.resume() //end of session.dataTask
        print(inputSentence)
        let tempString = inputSentence
        return tempString
    }
}


