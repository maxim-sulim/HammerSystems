//
//  CategoriesModel.swift
//  HummerSys
//
//  Created by Максим Сулим on 22.06.2023.
//

import Foundation


protocol CategoryProtocol{
    var name: String { get set }
}

struct Category: CategoryProtocol {
    var name: String
}

enum CategoryName {
    static var pizza = "Пицца"
    static var combo = "Комбо"
    static var desserts = "Десерты"
    static var drinks = "Напитки"
}
