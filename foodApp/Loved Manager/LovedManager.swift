//
//  LovedManager.swift
//  
//
//  Created by Ahmed on 8/31/20.
//

import Foundation

class LovedManager {
    
    var items = [Resturant]()
    
    static let shared = LovedManager()
    
    func addItem(_ item: Resturant?) {
        guard let item = item else {
            print("Restaurant Nil")
            return
        }
        if items.firstIndex(where: { (arrayItem) -> Bool in
            return arrayItem.id == item.id
        }) == nil {
            var LikedItem = item
            LikedItem.liked = true
            items.append(LikedItem)
        } else {
            print("Can't add restaurant!")
        }
        
    }
    
    func removeItem(_ item: Resturant?) {
        guard let item = item else { return }
        if let index = items.firstIndex(where: { (arrayItem) -> Bool in
            return arrayItem.id == item.id
        }) {
            items.remove(at: index)
        }
    }
    
    var totalItems: Int {
        return items.count
    }
    
}
