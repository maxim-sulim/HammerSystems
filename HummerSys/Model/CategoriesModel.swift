//
//  CategoriesModel.swift
//  HummerSys
//
//  Created by Максим Сулим on 22.06.2023.
//

import Foundation


protocol CategoryProtocol{
    var name: String { get set }
    var order: Int { get set }
    var isSelected: Bool { get set }
}

struct CategoryF: CategoryProtocol {
    var order: Int
    
    var name: String
    
    var isSelected: Bool
    
}

enum CategoryName {
    static var pizza = "Пицца"
    static var combo = "Комбо"
    static var desserts = "Десерты"
    static var drinks = "Напитки"
}
