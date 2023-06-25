//
//  MenuDecod.swift
//  HummerSys
//
//  Created by Максим Сулим on 24.06.2023.
//

import Foundation


// MARK: - Welcome
struct Welcome: Codable {
    let results: [Result]
    let info: Info
}

// MARK: - Info
struct Info: Codable {
    let seed, results, page, version: String
    let time: Time
    let user: User
}

// MARK: - Time
struct Time: Codable {
    let instruct, generate: Int
}

// MARK: - User
struct User: Codable {
    let username, tier, results, remaining: String
}

// MARK: - Result
struct Result: Codable {
    let customer: Customer
}

// MARK: - Customer
struct Customer: Codable {
    let arrItem: [ArrItem]
}

// MARK: - ArrItem
struct ArrItem: Codable {
    var category: Category
    let name, description, image, price: String
}

// MARK: - Category
struct Category: Codable {
    var order: String
    let name: String
    var isSelected: Bool
}
