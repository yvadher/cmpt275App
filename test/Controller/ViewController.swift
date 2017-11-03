//
//  ViewController.swift
//  test
//
//  Created by yvadher on 10/28/17.
//  Copyright © 2017 yvadher. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var photoCategory: [PhotoCategory] = PhotoCategory.fetchPhotos()
    @IBOutlet weak var displayCollection: UICollectionView!
    @IBOutlet weak var categoriesCollection: UICollectionView!
    @IBOutlet weak var pictographCollection: UICollectionView!    
    
    var clickedPhotos: [String] = []
    var currentCategory: Int = 0
    
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
        if (collectionView == self.displayCollection){
            return 1
        }else if (collectionView == self.categoriesCollection){
            return photoCategory.count
        }else if (collectionView == self.pictographCollection){
            return 1
        }else {
            print ("Should not come here ERROR in numberofsections")
            return 0
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.categoriesCollection){
            //print (photoCategory.count)
            return 1
        }else if (collectionView == self.pictographCollection){
            return photoCategory[currentCategory].imageNames.count
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
            let photos = photoCategory[currentCategory]
            let imageNames = photos.imageNames
            let imageName = imageNames[indexPath.item]
            cell.imageName = imageName
            print ("Current : \(currentCategory) And : \(photoCategory[indexPath.section].categoryName) ")
            
            return cell
            
        }else if (collectionView == self.displayCollection){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.displayBarCell, for: indexPath) as! displayBarCell
            let imageName = clickedPhotos[indexPath.item]
            
            cell.imageName = imageName
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.categoryCell, for: indexPath)
            print ("Came in else cell !! Shoudl not happen!!")
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == self.categoriesCollection){
           // let category = self.photoCategory[indexPath.section]
           // let image = UIImage(named: category.imageNames[indexPath.item])
            currentCategory = indexPath.section
            print ("\(currentCategory) : \(indexPath.section) ")
            
            pictographCollection.reloadData()
            
        }else if (collectionView == self.pictographCollection){
            
            let category = self.photoCategory[indexPath.section]
            clickedPhotos.append(category.imageNames[indexPath.item])
            print (clickedPhotos)
            print ("Came here!! \(category.imageNames[indexPath.item])")
            displayCollection.reloadData()
           
            
        }else if (collectionView == self.displayCollection){
            //do nothing
        }else {
            //Encapsulate in try and catch error block
            print ("This should not happen ! In the collectionView didselct!")
        }
        
    }
    
    

}

