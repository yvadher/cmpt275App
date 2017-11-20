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
//  11/10/2017 : Added forget email functionality class (Yagnik Vadher)
//  11/15/2017 : Synced up with server functionality (Yagnik Vadher)
//  11/16/2017 : Added a favorites buttons (Yagnik Vadher)
//  11/17/2017 : Changed the data model (Yagnik Vadher)
//             : Chnaged the liked buttons (Yagnik Vadher)
//             : Added category selection lable highlight
//             : Added like button in favorites category
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
    //varibles that tracks the display bar images (ClickedPhotos) and the currentCategory
    var clickedPhotos: [String] = []
    var currentCategory: Int = 0
    let favCategoryName : Int = -1
    
    //get the outlet for collection views
    @IBOutlet weak var displayCollection: UICollectionView!
    @IBOutlet weak var categoriesCollection: UICollectionView!
    @IBOutlet weak var pictographCollection: UICollectionView!
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    @IBOutlet weak var favoriteLableOutlet: UILabel!
    
    
    // Favorite button category action
    //1. change the picture collection view with favorites buttons

    @IBAction func favoriteButtonTapped(_ sender: Any) {
        // change current category to the favorite category and relode the category collection view and the pictographic collection view
        currentCategory = favCategoryName
        
        //change the pictographicColleciton view
        pictographCollection.reloadData()
        pictographCollection.layoutIfNeeded()
        
        //Relode category collection view
        categoriesCollection.reloadData()
        categoriesCollection.layoutIfNeeded()
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
            if (currentCategory == -1){
                return favoritesButtons.count
            }else
            {
                return photoCategory[currentCategory].imageNames.count
            }
            
            
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
            
            //If its Favorites category than change the bacground of button and layout for favorites and other category white backgroud
            if (currentCategory == -1 ){
                favoriteLableOutlet.backgroundColor = UIColorFromRGB(rgbValue: 0xe3f2fd)
                cell.categoryLable.backgroundColor = UIColorFromRGB(rgbValue: 0xffffff)
                
            }else {
                //If its normal category than change the bacground of category which is selected.
                favoriteLableOutlet.backgroundColor = UIColorFromRGB(rgbValue: 0xffffff)
                if (currentCategory == indexPath.section){
                    cell.categoryLable.backgroundColor = UIColorFromRGB(rgbValue: 0xe3f2fd)
                }else{
                    cell.categoryLable.backgroundColor = UIColorFromRGB(rgbValue: 0xffffff)
                }
            }
            
            return cell
            
        }else if (collectionView == self.pictographCollection) {
            
            //Add pictographic collection cell with the image and the label name
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.pictographCell, for: indexPath) as! pictographDisplayCell
            if (currentCategory == -1){
                cell.imageName = favoritesButtons[indexPath.item]
                cell.favoriteButton.setImage(UIImage(named: "filledHeart"), for: .normal)

                
            }else {
                cell.isLiked = false
                let photos = photoCategory[currentCategory]
                let imageNames = photos.imageNames
                let imageName = imageNames[indexPath.item]
                cell.imageName = imageName
                
                if (photoCategory[currentCategory].likedButtons[indexPath.item]){
                    cell.isLiked = true
                    cell.favoriteButton.setImage(UIImage(named: "filledHeart"), for: .normal)
                }else {
                    cell.favoriteButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
                }
                
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
            categoriesCollection.reloadData()
            categoriesCollection.layoutIfNeeded()
            pictographCollection.reloadData()
            pictographCollection.layoutIfNeeded()
        
        }else if (collectionView == self.pictographCollection) {
           
            //Speak the picture that is clicked and add it to the clickedButtons array
            var imgName : String = ""
            if (currentCategory == -1){
                imgName = favoritesButtons[indexPath.item]
            }else {
                let category = self.photoCategory[currentCategory]
                imgName = category.imageNames[indexPath.item]
            }
            
            
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
    
    //Function to convert rgb color to the UIcolor object
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}










