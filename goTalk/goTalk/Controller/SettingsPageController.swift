//
//  SettingsPageController.swift
//  goTalk
//
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
//  Created by Yagnik Vadher on 11/30/17.
//  Copyright © 2017 The Night Owls. All rights reserved.
//

import Foundation


struct settings {
    static var grammerCorrectionOn : Bool = UserDefaults.standard.bool(forKey: "grammer")
    static var speakSelectedWord : Bool = UserDefaults.standard.bool(forKey: "speakSelected")
    static var scrollBack : Bool = UserDefaults.standard.bool(forKey: "scrollBack")
}
class SettingsPageController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    
    override func viewDidLoad() {
        grammerCorrectionOutlet.setOn(UserDefaults.standard.bool(forKey: "grammer"), animated: true)
        speakSelectedWordOutlet.setOn(UserDefaults.standard.bool(forKey: "speakSelected"), animated: true)
        scrollBackOutlet.setOn(UserDefaults.standard.bool(forKey: "scrollBack"), animated: true)
        
        usernameLabel.text = UserDefaults.standard.string(forKey: "userName")
        emailLabel.text = UserDefaults.standard.string(forKey: "userEmail")
        
        picker.delegate = self
        pickerData = ["English" , "French"]
        
    }
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    @IBOutlet weak var grammerCorrectionOutlet: UISwitch!
    @IBOutlet weak var scrollBackOutlet: UISwitch!
    @IBOutlet weak var speakSelectedWordOutlet: UISwitch!
    
    @IBAction func grammerCorrectionChanged(_ sender: Any) {
        if (grammerCorrectionOutlet.isOn){
            settings.grammerCorrectionOn = true
            grammerCorrectionOutlet.setOn(true, animated: true)
            UserDefaults.standard.set(true, forKey: "grammer")
            UserDefaults.standard.synchronize()
        }else {
            settings.grammerCorrectionOn = false
            grammerCorrectionOutlet.setOn(false, animated: true)
            UserDefaults.standard.set(false, forKey: "grammer")
            UserDefaults.standard.synchronize()
        }
        
    }
    
    @IBAction func speakSelectedWord(_ sender: Any) {
        
        if (speakSelectedWordOutlet.isOn){
            settings.speakSelectedWord = true
            speakSelectedWordOutlet.setOn(true, animated: true)
            UserDefaults.standard.set(true, forKey: "speakSelected")
            UserDefaults.standard.synchronize()
        }else {
            settings.speakSelectedWord = false
            speakSelectedWordOutlet.setOn(false, animated: true)
            UserDefaults.standard.set(false, forKey: "speakSelected")
            UserDefaults.standard.synchronize()
        }
    }
    
    @IBAction func scrollBack(_ sender: Any) {
        if (scrollBackOutlet.isOn){
            settings.scrollBack = true
            scrollBackOutlet.setOn(true, animated: true)
            UserDefaults.standard.set(true, forKey: "scrollBack")
            UserDefaults.standard.synchronize()
        }else {
            settings.scrollBack = false
            scrollBackOutlet.setOn(false, animated: true)
            UserDefaults.standard.set(false, forKey: "scrollBack")
            UserDefaults.standard.synchronize()
        }
        
    }
    
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
   
   
  

    
}
