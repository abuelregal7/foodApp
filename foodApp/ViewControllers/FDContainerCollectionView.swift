//
//  FDContainerCollectionView.swift
//  foodApp
//
//  Created by Ahmed on 8/22/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class FDContainerCollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    var data: [CircleModel] = []
    var product = [CircleModel]()
    //var data: Home?
    var data1: CircleModel?
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //If you set it false, you have to add constraints.
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(FDCollectionViewCircle.self, forCellWithReuseIdentifier: FDCollectionViewCircle.reuseID)
        cv.backgroundColor = .clear
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRest()
        
        configureCollectionView()
        
    }
    
    
    
    func configureCollectionView() {
        
        view.addSubview(collectionView)
            

        //Add constraint
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    
    
    
    
    func getRest() {
        
        guard let url = URL(string: "http://i0sa.com/food/Home") else { return }
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
            
                switch response.result {
                    
                case .success(let value):
                    
                    if let JSON = value as? Dictionary<String, AnyObject> {
                        
                        let status = JSON["data"] as! Dictionary<String, AnyObject>
                        
                        print("--------------------------")
                        print("status is : \(status)")
                        print("--------------------------")
                        let title = status["title"] as! String
                        print("title is : \(title)")
                        print("--------------------------")
                        let typeRest = status["types"] as! [[String : Any]]
                        print("types is : \(typeRest)")
                        print("--------------------------")
                        for adic in typeRest {
                            
                            let id = adic["id"] as! Int
                            print("id is : \(id)")
                            
                            let title = adic["title"] as! String
                            print("title is : \(title)")
                            
                            let image = adic["image"] as! String
                            print("image is : \(image)")
                            
                            print("--------------------------")
                            print("--------------------------")
                            
                            self.product.append(CircleModel(
                                id:    (adic["id"] as? Int)!,
                                image: (adic["image"] as? String)!,
                                title: (adic["title"] as? String)!
                                
                            ))
                        
                        }
                        print("success")
                        
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
                    
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return product.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FDCollectionViewCircle.reuseID, for: indexPath) as! FDCollectionViewCircle
        
        
        DispatchQueue.main.async {
            //cell.image.image = UIImage(named: "18")
            //cell.title.text  = "1"
            //cell.title.text = "\(self.product[indexPath.row].title!)"
            let item = self.product[indexPath.row]
            //cell.configureImage(home: item)
            cell.configureImage(item)
        }
        return cell
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.collectionView.frame.size.width, height: 200)
//    }
}



