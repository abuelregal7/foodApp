//
//  Home.swift
//  foodApp
//
//  Created by Ahmed on 6/19/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation

// MARK: - Home
struct Home: Codable {
    let title: String?
    var types: [CircleModel]?
}

// MARK: - TypeElement
struct CircleModel: Codable {
    let id: Int?
    let image: String?
    let title: String?
    //var isSelected: Bool? = false
}
//class CircleModel {
//    
//    var id : Int?
//    var image: String?
//    var title: String?
//    
//    init(id: Int, image: String, title: String) {
//        
//        self.id     = id
//        self.image  = image
//        self.title  = title
//        
//    }
//}
