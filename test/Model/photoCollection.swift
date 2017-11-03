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
   
        for i in 0...(photosData.count-1) {
            let categoryImageName = photosData[i].caetegoryName
            if let imageNames = photosData[i].imagesNames as? [String] {
                let newCategory = PhotoCategory(categoryName: categoryImageName, title: categoryImageName, imageNames: imageNames)
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
    }
    class func downloadPhotosData() -> [categoryUnit]
    {
        let object = [
            categoryUnit(caetegoryName: "General", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "General")),
            categoryUnit(caetegoryName: "Feelings", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Feelings")),
            categoryUnit(caetegoryName: "Colors", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Colors")),
            categoryUnit(caetegoryName: "Drinks", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Drinks")),
            categoryUnit(caetegoryName: "Food", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Food")),
            categoryUnit(caetegoryName: "Places", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Places")),
            categoryUnit(caetegoryName: "Toys", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Toys")),
            categoryUnit(caetegoryName: "Numbers", imagesNames: PhotosLibrary.generateImage(categoryPrefix: "Numbers")),
        ]
        
        
        //print (object)
        return object
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








