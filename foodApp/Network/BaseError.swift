//
//  BaseError.swift
//  foodApp
//
//  Created by Ahmed on 6/19/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation

enum BaseError: Error {
//    case homeFailure
    case incorrectUsername
    case incorrectPassword
    case APIFailure
    case other(text: String)
    
    
    var MyDescription: String {
        switch self {
        case .APIFailure:
            return "Sorry, loading home failed"
        case .incorrectUsername:
            return "Sorry, incorrect username"
        case .incorrectPassword:
            return "Sorry, Incorrect Password"
        case .other(let text):
            return text
        }
    }
}
