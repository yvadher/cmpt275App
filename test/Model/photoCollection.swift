//
//  photoCollection.swift
//  test
//
//  Created by Yagnik Vadher on 11/2/17.
//  Copyright © 2017 ksd8. All rights reserved.
//

import Foundation

struct PhotoCategory {
    var categoryName: String
    var title: String
    var imageNames: [String]
    
    static func fetchPhotos() -> [PhotoCategory] {
        var categories = [PhotoCategory]()
        let photosData = PhotosLibrary.downloadPhotosData()
        
        for (categoryName, dict) in photosData {
            if let dict = dict as? [String : Any] {
                let categoryImageName = dict["categoryImageName"] as! String
                if let imageNames = dict["imageNames"] as? [String] {
                    let newCategory = PhotoCategory(categoryName: categoryImageName, title: categoryName, imageNames: imageNames)
                    categories.append(newCategory)
                }
            }
        }
        
        return categories
    }
}

class PhotosLibrary
{
    class func downloadPhotosData() -> [String : Any]
    {
        return [
            "General" : [
                "categoryImageName" : "General",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "General"),
            ],
            "Feelings" : [
                "categoryImageName" : "Feelings",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "Feelings"),
            ],
            "Colors" : [
                "categoryImageName" : "Colors",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "Colors"),
            ],
            "Drinks" : [
                "categoryImageName" : "Drinks",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "Drinks"),
            ],
            "Food" : [
                "categoryImageName" : "Food",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "Food"),
            ],
            "Places" : [
                "categoryImageName" : "Places",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "Places"),
            ],
            "Toys" : [
                "categoryImageName" : "Toys",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "Toys"),
            ],
            "Numbers" : [
                "categoryImageName" : "Numbers",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "Numbers"),
            ]
        ]
    }
    
    private class func generateImage(categoryPrefix: String) -> [String] {
        var imageNames = [String]()
        
        switch categoryPrefix {
        case "General":
            imageNames = ["i", "no", "ok", "see", "sleep", "what", "yes", "you"]
            
        case "Feelings":
            imageNames = ["afraid", "angry", "confused", "happy", "nervous", "sad", "shy", "sick", "surprised", "tired"]
            
        case "Colors":
            imageNames = ["black", "blue", "brown", "green", "grey", "orange", "pink", "purple", "red"]
            
        case "Food":
            imageNames = ["apple", "banana", "bread", "breakfast", "burger", "butter", "cake", "cereal", "chocolate", "grapes", "icecream", "noodles", "pizza", "sandwhich", "to_eat"]
            
        case "Drinks":
            imageNames = ["juice", "lemonade", "milk", "soda", "water"]
            
        case "Places":
            imageNames = ["home", "school", "clinic", "store", "bedroom", "bathroom", "kitchen", "plaground"]
            
        case "Toys":
            imageNames = ["ball", "book", "car", "color_pencil", "lego", "swing", "to_play"]
            
        case "Numbers":
            imageNames = ["nine", "eight", "seven", "six", "five", "four", "three", "two", "one", "zero"]
            
        default:
            imageNames = []
        }

        
        return imageNames
    }
}








