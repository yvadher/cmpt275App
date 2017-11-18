//
//  displayBarCell.swift
//  Class declaration of displayBarCell.
//
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
//  Created by Yagnik Vadher on 11/2/17.
//
//  Copyright © 2017 ksd8. All rights reserved.
//

import UIKit

class displayBarCell: UICollectionViewCell
{
    
    @IBOutlet weak var displayBarImg: UIImageView!
    
    var imageName: String! {
        didSet {
            displayBarImg.image = UIImage(named: imageName)
        }
    }
}


