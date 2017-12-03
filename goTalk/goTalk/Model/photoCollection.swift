//
//  photoCollection.swift
//  Contains struct PhotoCategory and class PhotosLibrary.
//      Manages Category Folders and Button Images.
//
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
//  Created by Yagnik Vadher on 11/2/17.
//  Worked on by Yagnik Vadher, Karamveer Dhillon, Fahd Chaudhry, and Shawn Thai.
//
//  11/02/2017: Added dynamic category changing.    (Yagnik Vadher)
//              Category objects changed from dictionary -> array objects to maintain order of elements. (Yagnik Vadher)
//  11/05/2017: Added Categories: Actions, Letters. Capitalized image names.    (Fahd Chaudhry, Shawn Thai)
//  11/17/2017: Favouriting functionality.  (Yagnik Vadher)
//  11/19/2017: Added more buttons.  (Shawn Thai)
//  12/1/2017:  Added more buttons. Bug found {new buttons not seen; buttons cannot be rearranged}. (Shawn Thai)
//
//  Copyright © 2017 ksd8. All rights reserved.
//

import Foundation

struct PhotoCategory : Codable {
    var userEmail : String
    var categoryName: String
    var title: String
    var imageNames: [String]
    var likedButtons : [Bool]
    
    static func fetchPhotos() -> [PhotoCategory] {
        var categories = [PhotoCategory]()
        let photosData = PhotosLibrary.downloadPhotosData()
        
        for i in 0...(photosData.count-1) {
            let categoryImageName = photosData[i].categoryName
            if let imageNames = photosData[i].imagesNames as? [String] {
                let newCategory = PhotoCategory(userEmail: "" ,categoryName: categoryImageName, title: categoryImageName, imageNames: imageNames, likedButtons : photosData[i].liked)
                categories.append(newCategory)
            }
        }
        return categories
    }
    
<<<<<<< HEAD
    // Function that returns the array of favorites buttons
=======
    //Function that returns the array of favorites buttons
>>>>>>> master
    static func fetchFavButtons(photoCat : [PhotoCategory] ) -> [String]{
        var favButtons : [String] = []
        for i in 0...(photoCat.count - 1 ){
            
            for j in 0...(photoCat[i].likedButtons.count - 1){
                if (photoCat[i].likedButtons[j]){
                    favButtons.append(photoCat[i].imageNames[j])
                }
            }
        }
        return favButtons
    }
}

class PhotosLibrary
{
    struct categoryUnit: Codable {
<<<<<<< HEAD
        let categoryName: String
=======
        let caetegoryName: String
>>>>>>> master
        let imagesNames : [String]
        let liked : [Bool]
    }
    class func downloadPhotosData() -> [categoryUnit]
    {
        let object = [
            categoryUnit(categoryName: "General", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "General"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "General")),
            categoryUnit(categoryName: "People", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "People"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "People")),
            categoryUnit(categoryName: "Actions", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Actions"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Actions")),
            categoryUnit(categoryName: "Feelings", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Feelings"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Feelings")),
            categoryUnit(categoryName: "Food", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Food"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Food")),
            categoryUnit(categoryName: "Drinks", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Drinks"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Drinks")),
            categoryUnit(categoryName: "Toys", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Toys"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Toys")),
            categoryUnit(categoryName: "Places", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Places"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Places")),
            categoryUnit(categoryName: "Colors", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Colors"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Colors")),
            categoryUnit(categoryName: "Numbers", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Numbers"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Numbers")),
            categoryUnit(categoryName: "Letters", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Letters"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Letters")),
            ]
        
        
        //print (object)
        return object
    }
    
    private class func generateImage(categoryPrefix: String) -> [String] {
        var imageNames = [String]()
        
        switch categoryPrefix {
        case "General":
            imageNames = ["i", "You", "Thank You", "Okay", "Yes", "No", "What", "Where", "Why", "Who", "Help", "Is", "It", "Do", "Not", "Now", "Later", "And", "Or", "Am", "Because", "But", "To", "On", "Up", "Down", "Left", "Right", "Big", "Small", "Tall"]
            
        case "People":
            imageNames = ["We", "They", "He", "She", "Family", "Mom", "Dad", "Sister", "Brother", "Teacher", "Doctor"]
            
        case "Actions":
            imageNames = ["Like", "Dislike", "See", "Look", "Hear", "Play", "Make", "Come", "Eat", "Think", "Give", "Sleep"]
            
        case "Feelings":
            imageNames = ["Happy", "Surprised", "Sorry", "Shy", "Nervous", "Afraid", "Confused", "Angry", "Tired", "Sleepy", "Sick", "Warm", "Hot", "Cold"]
            
        case "Colors":
            imageNames = ["Black", "Blue", "Brown", "Green", "Grey", "Orange", "Pink", "Purple", "Red"]
            
        case "Food":
            imageNames = ["Breakfast", "Lunch", "Dinner", "Snacks", "Vegetables", "Fruit", "Apple", "Banana", "Grapes", "Cereal", "Noodles", "Pizza", "Sandwich", "Bread", "Butter", "Chocolate", "IceCream"]
            
        case "Drinks":
            imageNames = ["Juice", "Lemonade", "Milk", "Soda", "Water", "Coffee", "Tea"]
            
        case "Places":
            imageNames = ["Home", "Bathroom", "School", "Store", "Bedroom", "Kitchen", "Playground", "Clinic"]
            
        case "Toys":
            imageNames = ["Ball", "Book", "Car", "Pencils", "Lego", "Swing"]
            
        case "Numbers":
            imageNames = ["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"]
            
        case "Letters":
            imageNames = ["A", "B", "C", "D", "E", "F", "G", "H", "I (Letter)", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
            
        default:
            imageNames = []
        }
        
        
        return imageNames
    }
    
    private class func generateImageLiked(categoryPrefix: String) -> [Bool] {
        var imageNames = [Bool]()
        
        switch categoryPrefix {
        case "General":
            imageNames = Array(repeating: false, count: 31)
        case "People":
            imageNames = Array(repeating: false, count: 11)
        case "Actions":
            imageNames = Array(repeating: false, count: 12)
        case "Feelings":
            imageNames = Array(repeating: false, count: 14)
        case "Colors":
            imageNames = Array(repeating: false, count: 9)
        case "Food":
            imageNames = Array(repeating: false, count: 17)
        case "Drinks":
            imageNames = Array(repeating: false, count: 7)
        case "Places":
            imageNames = Array(repeating: false, count: 8)
        case "Toys":
            imageNames = Array(repeating: false, count: 6)
        case "Numbers":
            imageNames = Array(repeating: false, count: 10)
        case "Letters":
            imageNames = Array(repeating: false, count: 26)
        default:
            imageNames = []
        }
        return imageNames
    }
}










