//
//  CategoriesCollectionViewCell.swift
//  HummerSys
//
//  Created by Максим Сулим on 22.06.2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    struct ViewModel{
        var index: Int = 0
        var name: String = ""
        var isSelected: Bool = false
        
    }
    
    private var model = ViewModel()
    
    //MARK конфигурация кнопки
    
    func configure(with viewModel: ViewModel) {
        
        model = viewModel
        categoriBut.setTitle(viewModel.name, for: .normal)
        
        configureLableCategory(button: self.categoriBut)
        
        
        if viewModel.isSelected == false {
            
            
            categoriBut.backgroundColor = .clear
            categoriBut.layer.borderWidth = 1.0
            categoriBut.layer.borderColor = Resources.Color.categorBackground.withAlphaComponent(0.2).cgColor
            
            
            let fontNoActive = UIFont.systemFont(ofSize: 13)
            let myNormalAttributedTitle = NSAttributedString(string: viewModel.name,
                                                             attributes: [NSAttributedString.Key.font: fontNoActive ])
            categoriBut.setAttributedTitle(myNormalAttributedTitle, for: .normal)
            
            categoriBut.setTitleColor(Resources.Color.categorBackground.withAlphaComponent(0.4), for: .normal)
            
        } else if viewModel.isSelected == true {
            categoriBut.layer.borderWidth = 0
            
            let fontActive = UIFont.boldSystemFont(ofSize: 13)
            
            let myActivelAttributedTitle = NSAttributedString(string: viewModel.name,
                                                              attributes: [NSAttributedString.Key.font: fontActive ])
            categoriBut.setAttributedTitle(myActivelAttributedTitle, for: .normal)
            categoriBut.setTitleColor(Resources.Color.activeRed, for: .normal)
            categoriBut.tintColor = Resources.Color.activeRed
            categoriBut.layer.backgroundColor = Resources.Color.categorBackground.withAlphaComponent(0.2).cgColor
        }
        
    }
    
    func configureLableCategory(button: UIButton) {
        
        button.tintColor = Resources.Color.categorBackground.withAlphaComponent(0.4)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1.0
        button.layer.borderColor = Resources.Color.categorBackground.withAlphaComponent(0.4).cgColor
        
}
    
    weak var delegate: CategoryCollectionProtocol?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBOutlet weak var categoriBut: UIButton!
    
    
    @IBAction func categoryAction(_ sender: Any) {
                
        let element = delegate?.categoriesArrCustomer
        
       
        if var element = element {
            
            
            
            for i in 0..<element.count {
                if element[i].isSelected == true {
                    element[i].isSelected = false
                }
            }
            
            element[model.index].isSelected = true
            delegate?.categoriesArrCustomer = element
            delegate?.reloadCategories(index: model.index)
        }
        
        
    }
        
}
