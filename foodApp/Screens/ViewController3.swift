//
//  ViewController3.swift
//  foodApp
//
//  Created by Ahmed on 8/22/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class ViewController3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen

        // Do any additional setup after loading the view.
        
        fetchResturant { (response) in
            print(response)
            switch response {
            case .success(let resturant):
                guard let resturants = resturant else { return }
                for rest in resturants {
                    print("success")
                    print("rest: \(rest.image)")

                }
            case .failure(_):
                print("Error")
            }
        }
        
    }
    
    
    
    func fetchResturant(completion: @escaping (Result<[ResturantFood]?, NSError>) -> Void ) {
        
        guard let url = URL(string: "http://i0sa.com/food/Rest") else { return }
        AF.request(url, method: .get, parameters: [:], headers: [:])
            .responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else { return }
            if statusCode == 200 { // success
                
                guard let jsonResponse = try? response.result.get() else { return }
                guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else { return }
                guard let responseObj = try? JSONDecoder().decode([ResturantFood].self, from: jsonData) else { return }
                completion(.success(responseObj))
                
                
            }
        }
        
    }


    
        
}
