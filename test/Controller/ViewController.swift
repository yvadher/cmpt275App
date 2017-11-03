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
    @IBOutlet weak var pictographCollection: UICollectionView!
    
    struct Storyboard {
        static let categoryCell = "categoryCell"
        
        static let headerView = "HeaderView"
        
        static let leftAndRightPaddings: CGFloat = 2.0
        static let numberOfItemsPerRow: CGFloat = 3.0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCollection.delegate = self
        displayCollection.dataSource = self
        
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        
        pictographCollection.delegate = self
        pictographCollection.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.categoriesCollection){
            return 1
        }else if (collectionView == self.pictographCollection){
            return 1
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.categoriesCollection){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.categoryCell, for: indexPath) as! categoryCell
            let photoCategory = self.photoCategory[indexPath.item]
            let categoryImageName =
            
            cell.imageName = imageName
            
            
        }else if (collectionView == self.pictographCollection){
            
        }
    }
    
    
    

 

}

