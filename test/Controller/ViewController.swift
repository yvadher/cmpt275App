//
//  ViewController.swift
//  test
//
//  Created by ksd8 on 10/28/17.
//  Copyright © 2017 ksd8. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var photoCategory: [PhotoCategory] = PhotoCategory.fetchPhotos()
    
    
    @IBOutlet weak var displayCollection: UICollectionView!
    
    @IBOutlet weak var categoriesCollection: UICollectionView!
    
    @IBOutlet weak var pictographCollection: pictographDisplayCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCollection.delegate = self
        displayCollection.dataSource = self
        
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        
        pictographCollection.delegate = self
        pictographCollection.dataSource = self
        
    }
    
    

 

}

