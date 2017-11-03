//
//  pictographDisplayCell.swift
//  test
//
//  Created by Yagnik Vadher on 11/2/17.
//  Copyright © 2017 ksd8. All rights reserved.
//

import Foundation

import UIKit

class pictographDisplayCell: UICollectionViewCell
{
    
    @IBOutlet weak var pictographImg: UIImageView!
    
    @IBOutlet weak var pictographLable: UILabel!
    
    var imageName: String! {
        didSet {
            pictographImg.image = UIImage(named: imageName)
            pictographLable.text = imageName
        }
    }
}
