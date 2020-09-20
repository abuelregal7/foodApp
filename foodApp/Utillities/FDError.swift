//
//  FDError.swift
//  foodApp
//
//  Created by Ahmed on 8/22/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation

enum FDError: String, Error {
    
    case invalidUserName     = "This username created an invalid request, please try again."
    case unableToComplete    = "Unable to complete your request, please check your internet connection."
    case invalidResponse     = "Invalid response fron a server, please try again"
    case invalidData         = "The data received from the server wa invalid, please try again"
    case unableToFavorite    = "there was an error favoriting this user. please try again"
    case alreadyInFavorites  = "You've already favorited this user. you must REALLY like them!"
    
}
