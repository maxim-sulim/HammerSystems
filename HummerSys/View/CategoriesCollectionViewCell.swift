//
//  CategoriesCollectionViewCell.swift
//  HummerSys
//
//  Created by Максим Сулим on 22.06.2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var categoriLable: UILabel!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
        func configureLableCategory() {
        self.categoriLable.textColor = Resources.Color.activeRed
      //  self.categoriLable.backgroundColor = Resources.Color.categorBackground
        self.categoriLable.layer.cornerRadius = 16
        self.categoriLable.layer.borderWidth = 1.0
        self.categoriLable.layer.borderColor = Resources.Color.categorBackground.cgColor
    }
  
}
