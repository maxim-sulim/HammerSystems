//
//  BannerCollectionViewController.swift
//  HummerSys
//
//  Created by Максим Сулим on 22.06.2023.
//

import UIKit

private let reuseIdentifier = "CellBanner"

class BannerCollectionViewController: UICollectionViewController {

    
    var banner = [BannerProtocol]()
    
    func loadBanners() {
        banner.append(Banner(nameImage: "pizzaBaner"))
        banner.append(Banner(nameImage: "pizzaBaner"))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return banner.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellBanner", for: indexPath) as! BannerCollectionViewCell
        cell.bannerImage.image = UIImage(named: banner[indexPath.row].nameImage)
        cell.configureLableBanner()
        return cell
    }

    
}
