//
//  categoryButtonCell.swift
//  test
//
//  Created by Yagnik Vadher on 11/2/17.
//  Copyright © 2017 ksd8. All rights reserved.
//

import UIKit

class categoryCell: UICollectionViewCell
{
    @IBOutlet weak var categoryImg: UIImageView!
    
    @IBOutlet weak var categoryLable: UILabel!
    
    var imageName: String! {
        didSet {
            categoryImg.image = UIImage(named: imageName)
            categoryLable.text = imageName
        }
    }
}

