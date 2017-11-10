//
//  ViewController.swift
//  Manages the Main Screen of the app.
//  Controls the organization of collection views and cells, horizontal scrolling, behaviour of buttons on user tap, and voice assistant.
//
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
//  Created by yvadher on 10/28/17.
//  Worked on by Yagnik Vadher, Karamveer Dhillon, Fahd Chaudhry, Shawn Thai, and Ryan Serkouh.
//
//  11/02/2017: Added images to render on screen. (Yagnik Vadher)
//              Fixed image glitch when pictographic button is tapped. (Yagnik Vadher)
//              Added text-to-speech functionality. (Yagnik Vadher)
//              Configured scrolling for pictograph buttons. (Karamveer Dhillon)
//  11/06/2017: Code formatting and removed comments used for debugging. (Shawn Thai)
//  11/10/2017: Code formatting. (Shawn Thai)
//
//  Copyright © 2017 yvadher. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var photoCategory: [PhotoCategory] = PhotoCategory.fetchPhotos()
    
    @IBOutlet weak var displayCollection: UICollectionView!
    @IBOutlet weak var categoriesCollection: UICollectionView!
    @IBOutlet weak var pictographCollection: UICollectionView!
   
    var clickedPhotos: [String] = []
    var currentCategory: Int = 0
    
    @IBAction func eraseButton(_ sender: Any) {
        if (!clickedPhotos.isEmpty){
            clickedPhotos.removeLast()
            displayCollection.reloadData()
        }
    }
    
    @IBAction func goButton(_ sender: Any) {
        let lineToSpeak: String = clickedPhotos.joined(separator: " ")
        speakLine(line: lineToSpeak)
    }
    
    
    struct Storyboard {
        static let categoryCell = "categoryCell"
        static let displayBarCell = "displayBarCell"
        static let pictographCell = "pictographDisplayCell"
        static let headerView = "HeaderView"
        
        static let leftAndRightPaddings: CGFloat = 2.0
        static let numberOfItemsPerRow: CGFloat = 3.0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCollection.delegate = self
        displayCollection.dataSource = self
        
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        
        pictographCollection.delegate = self
        pictographCollection.dataSource = self
        //print (photoCategory)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (collectionView == self.displayCollection) {
            return 1
        }
        else if (collectionView == self.categoriesCollection) {
            return photoCategory.count
        }
        else if (collectionView == self.pictographCollection) {
            return 1
        }
        else {
            print ("Error: Invalid result in numberOfSections")
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.categoriesCollection) {
            return 1
        }else if (collectionView == self.pictographCollection) {
            return photoCategory[currentCategory].imageNames.count
        }else if (collectionView == self.displayCollection) {
            return clickedPhotos.count
        }else{
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.categoriesCollection) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.categoryCell, for: indexPath) as! categoryCell
            let photos = photoCategory[indexPath.section]
            let imageName = photos.categoryName
            cell.imageName = imageName
            cell.categoryLable.text = imageName
            return cell
        }
        else if (collectionView == self.pictographCollection) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.pictographCell, for: indexPath) as! pictographDisplayCell
            let photos = photoCategory[currentCategory]
            let imageNames = photos.imageNames
            let imageName = imageNames[indexPath.item]
            cell.imageName = imageName
            return cell
        }
        else if (collectionView == self.displayCollection) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.displayBarCell, for: indexPath) as! displayBarCell
            let imageName = clickedPhotos[indexPath.item]
            cell.imageName = imageName
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.categoryCell, for: indexPath)
            print ("Error: Came in 'else' cell! Should not happen!")
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == self.categoriesCollection) {
            
            currentCategory = indexPath.section
            pictographCollection.reloadData()
            pictographCollection.layoutIfNeeded()
        }
        else if (collectionView == self.pictographCollection) {
            
            let category = self.photoCategory[currentCategory]
            let imgName = category.imageNames[indexPath.item]
            
            clickedPhotos.append(imgName)
            speakLine(line: imgName)
            print (clickedPhotos)
            print ("Came here!! \(imgName)")
            displayCollection.reloadData()
            displayCollection.layoutIfNeeded()
        }
        else if (collectionView == self.displayCollection) {
            // Do nothing
        }
        else {
            // Encapsulate in try and catch error block
            print ("Error: Should not happen!!")
        }
    }
    
    
    func speakLine(line: String){
        let speechSynthesizer = AVSpeechSynthesizer()
        let speechUtterance = AVSpeechUtterance(string: line)
        
        speechUtterance.rate = 0.45
        speechSynthesizer.speak(speechUtterance)
    }
}
