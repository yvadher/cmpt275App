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
    
    
    // call Photocategory model function to get the data of categories with its photos
    var photoCategory: [PhotoCategory] = PhotoCategory.fetchPhotos()
    var favoritesButtons : [String] = []
    //get the outlet for collection views
    @IBOutlet weak var displayCollection: UICollectionView!
    @IBOutlet weak var categoriesCollection: UICollectionView!
    @IBOutlet weak var pictographCollection: UICollectionView!
    
    //varibles that tracks the display bar images (ClickedPhotos) and the currentCategory
    var clickedPhotos: [String] = []
    var currentCategory: Int = 0
    
    
    //Erase button for removing the buttons from the display bar
    @IBAction func eraseButton(_ sender: Any) {
        if (!clickedPhotos.isEmpty){
            clickedPhotos.removeLast()
            displayCollection.reloadData()
        }
    }
    
    //go button for the playing the message
    @IBAction func goButton(_ sender: Any) {
        let lineToSpeak: String = clickedPhotos.joined(separator: " ")
        speakLine(line: lineToSpeak)    //Speak the passed arugument
    }
    
    //Struct object to keep track of the identifier
    struct Storyboard {
        static let categoryCell = "categoryCell"
        static let displayBarCell = "displayBarCell"
        static let pictographCell = "pictographDisplayCell"
    }
    
    //Initial setup function that asigns the collection view to delegates and dataSource
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCollection.delegate = self
        displayCollection.dataSource = self
        
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        
        pictographCollection.delegate = self
        pictographCollection.dataSource = self
    }
    
    //Return the number of section for each collection view (We have 3 collection view on main page)
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if (collectionView == self.displayCollection) {
            //Return 1 as display collection has only 1 section
            return 1
            
        }else if (collectionView == self.categoriesCollection) {
            //Return section as number of categories we have. (For now 8 category)
            return photoCategory.count
            
        }else if (collectionView == self.pictographCollection) {
             //Return 1 as poctographic button collection view has 1 section
            return 1
            
        }else {
            print ("Error: Invalid result in numberOfSections")  //Error handling
            return 0
        }
    }
    
    //Returns the number of items per section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == self.categoriesCollection) {
            // Each section in category has only 1 object (1 photo for directory)
            return 1
            
        }else if (collectionView == self.pictographCollection) {
            //return current category images count
            return photoCategory[currentCategory].imageNames.count
            
        }else if (collectionView == self.displayCollection) {
            //clicked images to form sentance on display bar
            return clickedPhotos.count
            
        }else{
            //Error handing
            return 0
        }
    }
    
    //Return cell for each type of the collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.categoriesCollection) {
            
            //Asign a category cell with the photo, categoryLable name
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.categoryCell, for: indexPath) as! categoryCell
            let photos = photoCategory[indexPath.section]
            let imageName = photos.categoryName
            cell.imageName = imageName
            cell.categoryLable.text = imageName
            return cell
            
        }else if (collectionView == self.pictographCollection) {
            
            //Add pictographic collection cell with the image and the label name
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.pictographCell, for: indexPath) as! pictographDisplayCell
            let photos = photoCategory[currentCategory]
            let imageNames = photos.imageNames
            let imageName = imageNames[indexPath.item]
            cell.imageName = imageName
            
            if (photoCategory[currentCategory].likedButtons[indexPath.item]){
                cell.favoriteButton.setImage(UIImage(named: "filledHeart"), for: .normal)
            }else {
                cell.favoriteButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
            }
            cell.delegate = self
            return cell
        
        }else if (collectionView == self.displayCollection) {
            
            //Add a display collection cell with the image only which is saved in the clickedImage[] array
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.displayBarCell, for: indexPath) as! displayBarCell
            let imageName = clickedPhotos[indexPath.item]
            cell.imageName = imageName
            return cell
        
        }else {
            
            //Error handling
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.categoryCell, for: indexPath)
            print ("Error: Came in 'else' cell! Should not happen!")
            return cell
        }
    }
    
    //If any cell in colleciton view is selected then perform action accordingly
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView == self.categoriesCollection) {
            
            //Change the content of the pictographic collection accroding to the category
            currentCategory = indexPath.section
            pictographCollection.reloadData()
            pictographCollection.layoutIfNeeded()
        
        }else if (collectionView == self.pictographCollection) {
           
            //Speak the picture that is clicked and add it to the clickedButtons array
            let category = self.photoCategory[currentCategory]
            let imgName = category.imageNames[indexPath.item]
            
            clickedPhotos.append(imgName)
            speakLine(line: imgName)
            displayCollection.reloadData()
            displayCollection.layoutIfNeeded()
        
        }else if (collectionView == self.displayCollection) {
            // Do nothing
        }
        else {
            // Encapsulate in try and catch error block
            print ("Error: Should not happen!!")
        }
    }
    
    //Speak function that speaks out string that is being passed as argument
    func speakLine(line: String){
        let speechSynthesizer = AVSpeechSynthesizer()
        let speechUtterance = AVSpeechUtterance(string: line)
        
        speechUtterance.rate = 0.45
        speechSynthesizer.speak(speechUtterance)
    }
}


extension ViewController: pictographicCellDelegate{
    func heartTapped(cell: pictographDisplayCell) {
        if let indexPath = pictographCollection.indexPath(for: cell){
            if (cell.isLiked){
                let imgName = photoCategory[currentCategory].imageNames[indexPath.item]
                photoCategory[currentCategory].likedButtons[indexPath.item] = false
                favoritesButtons = favoritesButtons.filter{$0 != imgName}
                print (favoritesButtons)
                cell.favoriteButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
                cell.isLiked = false
            }else {
                let imgName = photoCategory[currentCategory].imageNames[indexPath.item]
                photoCategory[currentCategory].likedButtons[indexPath.item] = true
                favoritesButtons.append(imgName)
                cell.favoriteButton.setImage(UIImage(named: "filledHeart"), for: .normal)
                cell.isLiked = true
            }
        }
    }
}







