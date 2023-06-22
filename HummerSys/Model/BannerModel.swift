//
//  BannerModel.swift
//  HummerSys
//
//  Created by Максим Сулим on 22.06.2023.
//

import Foundation


protocol BannerProtocol {
     var nameImage: String { get set }
}

struct Banner: BannerProtocol {
    
    var nameImage: String
    
}
