//
//  CategoriesCollectionViewController.swift
//  HummerSys
//
//  Created by Максим Сулим on 22.06.2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoriesCollectionViewController: UICollectionViewController  {

    var categories = [CategoryProtocol]()
    
    
    func loadCategories() {
        categories.append(Category(name: CategoryName.pizza))
        categories.append(Category(name: CategoryName.combo))
        categories.append(Category(name: CategoryName.desserts))
        categories.append(Category(name: CategoryName.drinks))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         categories.count
     }
     
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoriesCollectionViewCell
         cell.categoriLable.text = categories[indexPath.row].name
         cell.configureLableCategory()
         return cell
     }
    

}

