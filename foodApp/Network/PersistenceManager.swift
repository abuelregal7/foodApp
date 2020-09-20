//
//  PersistenceManager.swift
//  foodApp
//
//  Created by Ahmed on 8/31/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation

enum persistenceActionType {
    
    case add, remove
    
}

enum PersistenceManager {
    
    static private let defults = UserDefaults.standard
    
    enum Keys {
        
        static let favorites = "favorites"
        
    }
    
    static func updateWith(favorite: Resturant, actionType: persistenceActionType, completed: @escaping (FDError?) -> Void) {
        
        retrieveFavorites { result in
            
            switch result {
                
            case .success(let favorites):
                
                var retrievedFavorites = favorites
                
                switch actionType {
                
                case .add:
                    
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    retrievedFavorites.append(favorite)
                    
                case .remove:
                    
                    retrievedFavorites.removeAll {
                        $0.id == favorite.id
                    }
                }
                
                completed(save(favorites: retrievedFavorites))
                
            case .failure(let error):
                completed(error)
            }
            
        }
        
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Resturant],FDError>) -> Void) {
        
        guard let favoritesData = defults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
            
        }
        do {
            
            let decoder = JSONDecoder()
            //decoder.keyDecodingStrategy = .convertFromSnakeCase
            let favorites = try decoder.decode([Resturant].self, from: favoritesData)
            completed(.success(favorites))
            
        } catch {
            
            //completed(nil,error.localizedDescription)
            completed(.failure(.unableToFavorite))
    
        }
    }
    
    static func save(favorites: [Resturant]) -> FDError? {
        
        do {
            
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
            
        } catch  {
            
            return .unableToFavorite
            
        }
    }
}
