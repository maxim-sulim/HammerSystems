//
//  MenuModel.swift
//  HummerSys
//
//  Created by Максим Сулим on 22.06.2023.
//

import Foundation

protocol MenuProtocol{
    var name: String { get set }
    var description: String { get set }
    var image: String { get set }
    var price: String { get set }
}

struct Menu: MenuProtocol {
    var name: String
    
    var description: String
    
    var image: String
    
    var price: String

}
