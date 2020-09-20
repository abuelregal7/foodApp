//
//  NetworkManager.swift
//  foodApp
//
//  Created by Ahmed on 8/22/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared   = NetworkManager()
    private let baseURL = "http://i0sa.com/food/Home"
    
    private init() {}
    
    func getHome1 (completed: @escaping (Result<[CircleModel], FDError>) -> Void){
        
        guard let url = URL(string: baseURL) else{
            completed(.failure(.invalidUserName))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                
                completed(.failure(.unableToComplete))
                
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                completed(.failure(.invalidResponse))
                
                return
            }
            
            guard let data = data else{
                
                completed(.failure(.invalidData))
                
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let follower = try decoder.decode([CircleModel].self, from: data)
                completed(.success(follower))
                
            } catch {
                
                //completed(nil,error.localizedDescription)
                completed(.failure(.invalidData))
                
            }
        }
        task.resume()
        
    }
    
    func getHome() {
        
        
        
        
    }
    
}
