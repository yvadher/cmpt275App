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
    
    var clickedPhotos: [String] = []
    
    struct Storyboard {
        static let categoryCell = "categoryCell"
        static let displayBarCell = "displayBarCell"
        static let pictographCell = "pictographDisplayCell"
        
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photoCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.categoriesCollection){
            return photoCategory.count
        }else if (collectionView == self.pictographCollection){
            return photoCategory[section].imageNames.count
        }else if (collectionView == self.displayCollection) {
            return clickedPhotos.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.categoriesCollection){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.categoryCell, for: indexPath) as! categoryCell
            let photos = photoCategory[indexPath.section]
            let imageName = photos.categoryName
            
            //cell.imageName = imageName
            cell.categoryLable.text = imageName
            return cell
            
        }else if (collectionView == self.pictographCollection){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.pictographCell, for: indexPath) as! pictographDisplayCell
            let photos = photoCategory[indexPath.section]
            let imageNames = photos.imageNames
            let imageName = imageNames[indexPath.item]
            cell.imageName = imageName
            return cell
            
        }else if (collectionView == self.displayCollection){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.displayBarCell, for: indexPath) as! displayBarCell
            let imageName = clickedPhotos[indexPath.item]
            
            cell.imageName = imageName
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.categoryCell, for: indexPath) as! UICollectionViewCell
            print ("Came in else cell !! Shoudl not happen!!")
            return cell
        }
        
    }
 

}

