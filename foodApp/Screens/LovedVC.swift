//
//  LovedVC.swift
//  foodApp
//
//  Created by Ahmed on 8/31/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class LovedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var resturants               = [Resturant]()
    
    let backgroundImage          = UIImageView()
    let containerTableView       = UIView()
    let LoveTableView            = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgroundImage()
        configureContainertableView()
        configureTaleView()
        
        resturants = LovedManager.shared.items
        LoveTableView.reloadData()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        resturants = LovedManager.shared.items
        LoveTableView.reloadData()
    }
    
    
    
    func configureBackgroundImage() {
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "background")
        view.addSubview(backgroundImage)
        
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    func configureContainertableView() {
        
        containerTableView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.addSubview(containerTableView)
        containerTableView.backgroundColor  = .clear
        containerTableView.alpha            = 0.97
        
        NSLayoutConstraint.activate([
            
            containerTableView.topAnchor.constraint(equalTo: backgroundImage.safeAreaLayoutGuide.topAnchor, constant: 15),
            containerTableView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 0),
            containerTableView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: 0),
            containerTableView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 0)
            
        ])
        
    }
    
    func configureTaleView() {
        
        containerTableView.addSubview(LoveTableView)
        LoveTableView.backgroundColor = .clear
        LoveTableView.translatesAutoresizingMaskIntoConstraints = false
        LoveTableView.frame           = view.bounds
        LoveTableView.rowHeight       = 299
        LoveTableView.delegate        = self
        LoveTableView.dataSource      = self
        
        LoveTableView.register(FDResturantTableViewCell.self, forCellReuseIdentifier: FDResturantTableViewCell.reuseID)
        
        NSLayoutConstraint.activate([
            
            LoveTableView.leadingAnchor.constraint(equalTo: containerTableView.leadingAnchor),
            LoveTableView.trailingAnchor.constraint(equalTo: containerTableView.trailingAnchor),
            LoveTableView.topAnchor.constraint(equalTo: containerTableView.topAnchor),
            LoveTableView.bottomAnchor.constraint(equalTo: containerTableView.bottomAnchor)
            
        ])
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resturants.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = LoveTableView.dequeueReusableCell(withIdentifier: FDResturantTableViewCell.reuseID) as! FDResturantTableViewCell
        
        let item = self.resturants[indexPath.row]
        cell.configureImage(item)
        cell.cuisineLable.text        = "Cuisine"
        cell.deliveryTimeTitle.text   = "Delivery time"
        cell.ratingLable.text         = "Rating"
        
        cell.delegate = self
        cell.backgroundColor          = .lightGray
        cell.restTitleLable.textColor = .black
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 1.set initial state of the cell
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = CATransform3DIdentity
        //2.uiView animation method to change to the final stse of cell
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
    }

    

}

//extension LovedVC: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return resturants.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = LoveTableView.dequeueReusableCell(withIdentifier: FDResturantTableViewCell.reuseID2) as! FDResturantTableViewCell
//
//        let item = self.resturants[indexPath.row]
//        cell.configureImage(item)
//        cell.backgroundColor = .lightGray
//        cell.selectionStyle = .none
//        cell.restTitleLable.textColor = .black
//        //cell.loveButton.set(backgroundColor: .clear, title: "", cornerRadius: 0, backgroundImage: UIImage(named: "like")!, tintColor: .systemIndigo)
//        cell.loveButton.contentMode   = .scaleToFill
//        cell.cuisineLable.text        = "Cuisine"
//        cell.viewForCollectionView.backgroundColor = .white
//        cell.deliveryTimeTitle.text   = "Delivery time"
//        cell.ratingLable.text         = "Rating"
//
//        cell.delegate = self
//
//        return cell
//    }
//
//
//
//
//}
extension LovedVC: LoveRestaurantDelegate {
    func loveRestaurant(rest: Resturant) {
        //
    }
    
    func disLoveRestaurant(rest: Resturant) {
        if let row = resturants.firstIndex(where: { (restaurant) -> Bool in
            restaurant.id == rest.id
        }) {
            print("removing a restaurant from loved ...")
            resturants.remove(at: row)
            LoveTableView.reloadData()
        }
    }
}


