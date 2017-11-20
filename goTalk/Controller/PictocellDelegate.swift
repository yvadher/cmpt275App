//
//  PictocellDelegate.swift
//  goTalk
//
//  Created by Yagnik Vadher on 2017-11-17.
//  Copyright © 2017 The Night Owls. All rights reserved.
//

import UIKit

extension ViewController: pictographicCellDelegate{
    func heartTapped(cell: pictographDisplayCell) {
        if let indexPath = pictographCollection.indexPath(for: cell){
            // If cell is liked than chage the heart to filled heart
            if (cell.isLiked){
                print("if isLIked, -> filled to empty, isLiked = false")
                //If current category is favorites then remove heart and relode the pictographic collection
                if (currentCategory == -1){
                    print("currentCategory == -1 reached, filled to empty, isLiked = false")
                    let imgName = favoritesButtons[indexPath.item]
                    favoritesButtons = favoritesButtons.filter{$0 != imgName}
                    cell.favoriteButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
                    cell.isLiked = false
                    pictographCollection.reloadData()
                    pictographCollection.layoutIfNeeded()
                    
                //If category is not the favorites then remove the heart sign and set heart to empty heart img
                }else{
                    print("sub else -> fill to empty, isLiked = false")
                    let imgName = photoCategory[currentCategory].imageNames[indexPath.item]
                    photoCategory[currentCategory].likedButtons[indexPath.item] = false
                    favoritesButtons = favoritesButtons.filter{$0 != imgName}
                    cell.favoriteButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
                    cell.isLiked = false
                }
                
            //If cell is not liked then add a filled heart and change data to Photographic model
            }else {
                print("main else -> empty to filled, isLiked = true")
                let imgName = photoCategory[currentCategory].imageNames[indexPath.item]
                photoCategory[currentCategory].likedButtons[indexPath.item] = true
                favoritesButtons.append(imgName)
                cell.favoriteButton.setImage(UIImage(named: "filledHeart"), for: .normal)
                cell.isLiked = true
            }
        }
    }
}
