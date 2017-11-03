//
//  displayBarCell.swift
//  test
//
//  Created by Yagnik Vadher on 11/2/17.
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


