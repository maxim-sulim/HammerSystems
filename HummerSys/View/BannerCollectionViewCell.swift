//
//  BannerCollectionViewCell.swift
//  HummerSys
//
//  Created by Максим Сулим on 22.06.2023.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
 
    
    @IBOutlet weak var bannerImage: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureLableBanner() {
    self.bannerImage.layer.cornerRadius = 10
    self.bannerImage.backgroundColor = Resources.Color.categorBackground
        self.bannerImage.contentMode = .scaleAspectFill
    }
}
