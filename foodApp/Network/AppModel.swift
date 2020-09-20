//
//  ErrorsModel.swift
//  foodApp
//
//  Created by Ahmed on 6/19/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation

struct AppModel<T: Decodable>: Decodable {
    var status: statusEnum?
    var data: T?
    var message: String?
    
    enum statusEnum: String, Decodable {
        case fail = "fail"
        case success = "success"
    }
}
