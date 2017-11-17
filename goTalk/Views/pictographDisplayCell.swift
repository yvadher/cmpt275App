//
//  pictographDisplayCell.swift
//  Class declaration of pictographDisplayCell.
//
//  CMPT 275 Fall 2017 - Group 02: The Night Owls
//  Created by Yagnik Vadher on 11/2/17.
//
//  Copyright © 2017 ksd8. All rights reserved.
//

import Foundation

import UIKit

protocol pictographicCellDelegate: class {
    func heartTapped(cell : pictographDisplayCell)
}

class pictographDisplayCell: UICollectionViewCell
{
    weak var delegate: pictographicCellDelegate?
    
    @IBOutlet weak var pictographImg: UIImageView!
    
    @IBOutlet weak var pictographLable: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var isLiked: Bool = false
    // For border colors
    var borderColor = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)    
    
    var imageName: String! {
        didSet {
            pictographImg.image = UIImage(named: imageName)
            pictographImg.layer.borderColor = borderColor.cgColor
            pictographImg.layer.borderWidth = 0.5
            pictographImg.layer.masksToBounds = true
            pictographImg.layer.cornerRadius = 10
            pictographLable.text = imageName
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        delegate?.heartTapped(cell: self)
    }
    
}

