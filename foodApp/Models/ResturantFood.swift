//
//  ResturantFood.swift
//  FoodDelivery
//
//  Created by Ahmed on 6/19/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation

struct ResturantFood: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let price: Int?
    let currency: String?
    var quantity: Int?
    
    func formattedPrice() -> String {
        return "\(price ?? 0) \(currency ?? "")"
    }
    
    func formatedTotalPrice() -> String {
        return "\(currency ?? "") \((price ?? 0) * (quantity ?? 0))"
    }
    
}

extension ResturantFood: Equatable {
    static func ==(lhs: ResturantFood, rhs: ResturantFood) -> Bool {
        return lhs.id == rhs.id
    }
}
