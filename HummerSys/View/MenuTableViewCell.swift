//
//  MenuTableViewCell.swift
//  HummerSys
//
//  Created by Максим Сулим on 22.06.2023.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageMenu: UIImageView!
    @IBOutlet weak var nameMenu: UILabel!
    @IBOutlet weak var descriptionMenu: UILabel!
    @IBOutlet weak var priceMenu: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLablePrice()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func configureLablePrice() {
        self.priceMenu.textColor = Resources.Color.activeRed
        self.priceMenu.layer.cornerRadius = 6
        self.priceMenu.layer.borderWidth = 1.0
        self.priceMenu.layer.borderColor = Resources.Color.activeRed.cgColor
    }

}
