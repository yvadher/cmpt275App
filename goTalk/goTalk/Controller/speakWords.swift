//
//  speakWords.swift
//  goTalk
//
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
//  Created by Yagnik Vadher on 2017-11-17.
//
//  12/01/2017: Comments and formatting.    (Shawn Thai)
//  Copyright © 2017 The Night Owls. All rights reserved.

import UIKit
import AVFoundation

// Speak function that speaks out string that is being passed as argument
extension ViewController {
    
    func speakLine(line: String){
        
        let speechSynthesizer = AVSpeechSynthesizer()
        var lineToSpeak :String = line
        
        if (UserDefaults.standard.string(forKey: "UserLang") == "fr-CA"){
            lineToSpeak = getInFrench(stringToSpeak: line)
        }else {
            lineToSpeak = line
        }
        
        let speechUtterance = AVSpeechUtterance(string: lineToSpeak)
        
        if (UserDefaults.standard.string(forKey: "UserLang") != nil){
            speechUtterance.voice = AVSpeechSynthesisVoice(language: UserDefaults.standard.string(forKey: "UserLang") )
        }
        
        speechUtterance.rate = 0.45
        speechSynthesizer.speak(speechUtterance)
        
        
    }
    
    // This is how you can join the string:
    // let lineToSpeak: String = clickedPhotos.joined(separator: " ")
    
    
    // correctGrammar takes in the string data from the displayBar and sends it to a grammar-correcting api.
    // The api gives the phrase a grammar score of 0-100, where 100 is identified as "good grammar."
    // If score < 100, then the api suggests grammar corrections to the phrase, which replaces the original string data.
    func correctGrammer(_ sendJSON: String, completion: @escaping (Any?) -> Void ) -> String{
        let inputSentencePlus = self.clickedPhotos.joined(separator: "+")
        var inputSentence = self.clickedPhotos.joined(separator: " ")
        print("Print 1")
        //URL for the server API
        let apiKey = "&key=CEjByKpLU5oTE6qg"
        let apiURL = "https://api.textgears.com/check.php?text="
        print(sendJSON)
        let joinedURL = apiURL + inputSentencePlus + apiKey
        print(joinedURL)
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
                    
                    
                    if ((json["score"] == nil) ){
                        print (json["score"])
                        completion(inputSentence)
                        return
                    }
                    
                    let result = json["score"] as! Int
                    if(result == 100){
                        print("RESULT LESS THAN 100")
                        completion(inputSentence)
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
                }
            } // end of if let data = data
            
            }.resume() //end of session.dataTask
        
        print(inputSentence)
        let tempString = inputSentence
        return tempString
    }
    
    
    func getInFrench(stringToSpeak : String) -> String {
        var str : String = stringToSpeak
        
        switch str {
            case "And":
                str = "Et"
            case "Actions":
                str = "Actes"
            case "Afraid":
                str = "Peur"
            case "Am":
                str = "Suis"
            case "Angry":
                str = "Furieux"
            case "Apple":
                str = "Pomme"
            case "Ball":
                str = "Ballon"
            case "Banana":
                str = "Banane"
            case "Bathroom":
                str = "Salle de bains"
            case "Because":
                str = "Car"
            case "Bedroom":
                str = "Chambre"
            case "Big":
                str = "Gros"
            case "Black":
                str = "Noir"
            case "Blue":
                str = "Bleu"
            case "Book":
                str = "Livre"
            case "Bread":
                str = "Pain"
            case "Breakfast":
                str = "Déjeuner"
            case "Brother":
                str = "Frère"
            case "Brown":
                str = "marron"
            case "Burger":
                str = "Burger"
            case "But":
                str = "Mais"
            case "Butter":
                str = "Beurre"
            case "Car":
                str = "Voiture"
            case "Cereal":
                str = "Céréale"
            case "Chocolate":
                str = "Chocolat"
            case "Classroom":
                str = "Salle de classe"
            case "Clinic":
                str = "Clinique"
            case "Coffee":
                str = "café"
            case "Cold":
                str = "Du froid"
            case "Colors":
                str = "Couleurs"
            case "Come":
                str = "Viens"
            case "Confused":
                str = "Confus"
            case "Dad":
                str = "Papa"
            case "Dinner":
                str = "Dîner"
            case "Dislike":
                str = "Ne pas aimer"
            case "Do":
                str = "Faire"
            case "Doctor":
                str = "Docteur"
            case "Down":
                str = "Vers le bas"
            case "Drinks":
                str = "Boissons"
            case "Eat":
                str = "Manger"
            case "Eight":
                str = "Huit"
            case "Family":
                str = "Famille"
            case "Favourites":
                str = "Favoris"
            case "Feelings":
                str = "Sentiments"
            case "Five":
                str = "Cinq"
            case "Food":
                str = "Aliments"
            case "Four":
                str = "Quatre"
            case "Fruit":
                str = "Fruit"
            case "General":
                str = "Général"
            case "Give":
                str = "Donner"
            case "Go":
                str = "Aller"
            case "Grapes":
                str = "les raisins"
            case "Green":
                str = "vert"
            case "Grey":
                str = "Gris"
            case "Happy":
                str = "Content"
            case "He":
                str = "Il"
            case "Hear":
                str = "Entendre"
            case "Help":
                str = "Aidez"
            case "Home":
                str = "Accueil"
            case "Hot":
                str = "Chaud"
            case "i":
                str = "Je"
            case "IceCream":
                str = "Crème glacée"
            case "In":
                str = "Dans"
            case "Is":
                str = "Est"
            case "It":
                str = "Il"
            case "Juice":
                str = "jus"
            case "Kitchen":
                str = "Cuisine"
            case "Later":
                str = "Plus tard"
            case "Left":
                str = "La gauche"
            case "Lego":
                str = "Lego"
            case "Lemonade":
                str = "limonade"
            case "Letters":
                str = "Des lettres"
            case "Like":
                str = "Comme"
            case "Look":
                str = "Regardez"
            case "Lunch":
                str = "Le déjeuner"
            case "Make":
                str = "Faire"
            case "Milk":
                str = "Lait"
            case "Mom":
                str = "Maman"
            case "Nervous":
                str = "Nerveux"
            case "Nine":
                str = "Neuf"
            case "No":
                str = "Non"
            case "Noodles":
                str = "Nouilles"
            case "Not":
                str = "ne pas"
            case "Now":
                str = "présent"
            case "Numbers":
                str = "Nombres"
            case "Okay":
                str = "d'accord"
            case "On":
                str = "Sur"
            case "One":
                str = "Un"
            case "Or":
                str = "Ou"
            case "Orange":
                str = "Orange"
            case "Pencils":
                str = "Des crayons"
            case "People":
                str = "Gens"
            case "Pink":
                str = "Rose"
            case "Pizza":
                str = "Pizza"
            case "Places":
                str = "Des endroits"
            case "Play":
                str = "Jouer"
            case "Playground":
                str = "Cour de récréation"
            case "Purple":
                str = "Violet"
            case "Questions":
                str = "Des questions"
            case "Red":
                str = "rouge"
            case "Right":
                str = "Droite"
            case "Sad":
                str = "Triste"
            case "Sandwich":
                str = "Sandwich"
            case "School":
                str = "École"
            case "See":
                str = "Voir"
            case "Seven":
                str = "Sept"
            case "She":
                str = "Elle"
            case "Shy":
                str = "Timide"
            case "Sick":
                str = "Malade"
            case "Sister":
                str = "Sœur"
            case "Six":
                str = "Six"
            case "Sleep":
                str = "Dormir"
            case "Sleepy":
                str = "Somnolent"
            case "Small":
                str = "Petit"
            case "Snacks":
                str = "Collations"
            case "Soda":
                str = "Un soda"
            case "Sorry":
                str = "Pardon"
            case "Store":
                str = "le magasin"
            case "Surprised":
                str = "Surpris"
            case "Swing":
                str = "Balançoire"
            case "Tall":
                str = "Grand"
            case "Tea":
                str = "thé"
            case "Teacher":
                str = "Prof"
            case "Thank You":
                str = "Je vous remercie"
            case "They":
                str = "Ils"
            case "Think":
                str = "Pense"
            case "Three":
                str = "Trois"
            case "Tired":
                str = "Fatigué"
            case "To":
                str = "À"
            case "Toys":
                str = "Jouets"
            case "Two":
                str = "Deux"
            case "Up":
                str = "Up"
            case "Vegetables":
                str = "Des légumes"
            case "Warm":
                str = "Chaud"
            case "Water":
                str = "Eau"
            case "We":
                str = "nous"
            case "What":
                str = "Quelle"
            case "Where":
                str = "Où"
            case "Who":
                str = "Qui"
            case "Why":
                str = "Pourquoi"
            case "Yes":
                str = "Oui"
            case "You":
                str = "Toi"
            case "Zero":
                str = "Zéro"
           
            default: break
        }
        
        return str
    }
}


