//
//  photoCollection.swift
//  Contains struct PhotoCategory and class PhotosLibrary.
//      Manages Category Folders and Button Images.
//
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
//  Created by Yagnik Vadher on 11/2/17.
//  Worked on by Yagnik Vadher, Karamveer Dhillon, Fahd Chaudhry, and Shawn Thai.
//
//  11/02/2017: Added dynamic category changing. (Yagnik Vadher)
//              Category objects changed from dictionary -> array objects to maintain order of elements. (Yagnik Vadher)
//  11/05/2017: Added Categories: Actions, Letters. Capitalized image names (Fahd Chaudhry, Shawn Thai).
//
//  Copyright © 2017 ksd8. All rights reserved.
//

import Foundation

struct PhotoCategory {
    var categoryName: String
    var title: String
    var imageNames: [String]
    var likedButtons : [Bool]
    
    static func fetchPhotos() -> [PhotoCategory] {
        var categories = [PhotoCategory]()
        let photosData = PhotosLibrary.downloadPhotosData()
   
        for i in 0...(photosData.count-1) {
            let categoryImageName = photosData[i].caetegoryName
            if let imageNames = photosData[i].imagesNames as? [String] {
                let newCategory = PhotoCategory(categoryName: categoryImageName, title: categoryImageName, imageNames: imageNames, likedButtons : photosData[i].liked)
                categories.append(newCategory)
            }
        }
        return categories
    }
}

class PhotosLibrary
{
    struct categoryUnit{
        let caetegoryName: String
        let imagesNames : [String]
        let liked : [Bool]
    }
    class func downloadPhotosData() -> [categoryUnit]
    {
        let object = [
            categoryUnit(caetegoryName: "General", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "General"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "General")),
            categoryUnit(caetegoryName: "Feelings", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Feelings"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Feelings")),
            categoryUnit(caetegoryName: "Colors", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Colors"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Colors")),
            categoryUnit(caetegoryName: "Drinks", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Drinks"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Drinks")),
            categoryUnit(caetegoryName: "Food", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Food"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Food")),
            categoryUnit(caetegoryName: "Places", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Places"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Places")),
            categoryUnit(caetegoryName: "Toys", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Toys"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Toys")),
            categoryUnit(caetegoryName: "Numbers", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Numbers"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Numbers")),
            categoryUnit(caetegoryName: "Letters", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Letters"), liked: PhotosLibrary.generateImageLiked(categoryPrefix: "Letters")),
        ]
        
        
        //print (object)
        return object
    }
    
    private class func generateImage(categoryPrefix: String) -> [String] {
        var imageNames = [String]()
        
        switch categoryPrefix {
        case "General":
            imageNames = ["i", "No", "Okay", "See", "Sleep", "What", "Yes", "You", "Dislike", "Hear", "Like"]
            
        case "Feelings":
            imageNames = ["Afraid", "Angry", "Confused", "Happy", "Nervous", "Sad", "Shy", "Sick", "Surprised", "Tired"]
            
        case "Colors":
            imageNames = ["Black", "Blue", "Brown", "Green", "Grey", "Orange", "Pink", "Purple", "Red"]
            
        case "Food":
            imageNames = ["Apple", "Banana", "Bread", "Breakfast", "Burger", "Butter", "Cereal", "Chocolate", "Grapes", "IceCream", "Noodles", "Pizza", "Sandwich", "Eat"]
            
        case "Drinks":
            imageNames = ["Juice", "Lemonade", "Milk", "Soda", "Water"]
            
        case "Places":
            imageNames = ["Home", "School", "Clinic", "Store", "Bedroom", "Bathroom", "Kitchen", "Playground"]
            
        case "Toys":
            imageNames = ["Ball", "Book", "Car", "Pencils", "Lego", "Swing", "Play"]
            
        case "Numbers":
            imageNames = ["Nine", "Eight", "Seven", "Six", "Five", "Four", "Three", "Two", "One", "Zero"]
        
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
            imageNames = Array(repeating: false, count: 11)
        case "Feelings":
            imageNames = Array(repeating: false, count: 10)
        case "Colors":
            imageNames = Array(repeating: false, count: 9)
        case "Food":
            imageNames = Array(repeating: false, count: 14)
        case "Drinks":
            imageNames = Array(repeating: false, count: 5)
        case "Places":
            imageNames = Array(repeating: false, count: 8)
        case "Toys":
            imageNames = Array(repeating: false, count: 7)
        case "Numbers":
            imageNames = Array(repeating: false, count: 10)
        case "Letters":
            imageNames = Array(repeating: false, count: 26)
        default:
            imageNames = []
        }
        print ("\(categoryPrefix)  -> \(imageNames)")
        return imageNames
    }
}










