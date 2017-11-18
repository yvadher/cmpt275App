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
                let imgName = photoCategory[currentCategory].imageNames[indexPath.item]
                photoCategory[currentCategory].likedButtons[indexPath.item] = false
                favoritesButtons = favoritesButtons.filter{$0 != imgName}
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
