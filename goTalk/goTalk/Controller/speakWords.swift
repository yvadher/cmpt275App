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

}


