//
//  categoryButtonCell.swift
//  Class declaration of categoryCell.
//
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
//  Created by Yagnik Vadher on 11/2/17.
//
//  Copyright © 2017 ksd8. All rights reserved.
//

import UIKit

class categoryCell: UICollectionViewCell
{
    @IBOutlet weak var categoryImg: UIImageView!
    
    @IBOutlet weak var categoryLable: UILabel!
    
    @IBOutlet weak var categoryButtonOutlet: UIImageView!
    var imageName: String! {
        didSet {
            categoryImg.image = UIImage(named: imageName)
            categoryLable.text = imageName
        }
    }
}

