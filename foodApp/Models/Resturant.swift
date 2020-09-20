//
//  Resturant.swift
///  foodApp
//
//  Created by Ahmed on 6/19/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation
// MARK: - ResturantElement
struct Resturant: Codable, Equatable {
    let id: Int?
    let title: String?
    let image: String?
    let delivery_time: String?
    let rating: Double?
    let rating_count: Int?
    let genres: [String]?
    var liked: Bool?
    //let is_exculsive: Bool?
//    enum CodingKeys: String, CodingKey {
//        case id, title, image
//        case deliveryTime = "delivery_time"
//        case rating
//        case ratingCount = "rating_count"
//        case genres, liked
//        case isExculsive = "is_exculsive"
//    }
}
struct Genres: Codable {
    
    let genres: [String]?
    
}
