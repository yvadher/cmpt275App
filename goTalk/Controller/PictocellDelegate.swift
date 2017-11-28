//
//  PictocellDelegate.swift
//  goTalk
//
//  Created by Yagnik Vadher on 2017-11-17.
//  Copyright © 2017 The Night Owls. All rights reserved.
//

import UIKit
import Foundation

extension ViewController: pictographicCellDelegate{
    
    
    
    //MARK: Helper function
    // Function that keep tracks of the heart button being liked or not according to there image names
    func changeLikedButton(str : String){
        for i in 0...(photoCategory.count-1){
            for j in 0...(photoCategory[i].imageNames.count-1){
                if (photoCategory[i].imageNames[j] == str){
                     photoCategory[i].likedButtons[j] = !photoCategory[i].likedButtons[j]
                }
            }
        }
    }
    //Function that is called when user presses the favorites button
    func heartTapped(cell: pictographDisplayCell) {
        if let indexPath = pictographCollection.indexPath(for: cell){
            // If cell is liked than chage the heart to filled heart
            if (cell.isLiked){
                
                //If current category is favorites then remove heart and relode the pictographic collection
                if (currentCategory == -1){
                    
                    let imgName = favoritesButtons[indexPath.item]
                    favoritesButtons = favoritesButtons.filter{$0 != imgName}
                    changeLikedButton(str: imgName)
                    cell.favoriteButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
                    cell.isLiked = false
                    //Relode the collection view
                    pictographCollection.reloadData()
                    pictographCollection.layoutIfNeeded()
                    
                //If category is not the favorites then remove the heart sign and set heart to empty heart img
                }else{
                    let imgName = photoCategory[currentCategory].imageNames[indexPath.item]
                    photoCategory[currentCategory].likedButtons[indexPath.item] = false
                    favoritesButtons = favoritesButtons.filter{$0 != imgName}
                    cell.favoriteButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
                    cell.isLiked = false
                }
                
            //If cell is not liked then add a filled heart and change data to Photographic model
            }else {
                let imgName = photoCategory[currentCategory].imageNames[indexPath.item]
                photoCategory[currentCategory].likedButtons[indexPath.item] = true
                favoritesButtons.append(imgName)
                cell.favoriteButton.setImage(UIImage(named: "filledHeart"), for: .normal)
                cell.isLiked = true
            }
        }
        //save json
        //encoderJson(photoCategory: photoCategory)
        //Save user logged in(true) information to the userDefaults
        UserDefaults.standard.set(try? PropertyListEncoder().encode(photoCategory), forKey:"mainData")
        //UserDefaults.standard.set( encodedData , forKey: "mainData")
        UserDefaults.standard.synchronize()
        
    }
}
