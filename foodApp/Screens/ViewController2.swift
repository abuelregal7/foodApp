//
//  ViewController2.swift
//  foodApp
//
//  Created by Ahmed on 8/22/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let backgroundImage = FDImageView(cornerRadius: 0)
    
    let loveTableView = UITableView()
    
    var resturant = [Resturant]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        configureBackgroundImage()
        configureTableView()
        
        resturant = LovedManager.shared.items
        loveTableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        resturant = LovedManager.shared.items
        loveTableView.reloadData()
    }
    
    func configureBackgroundImage() {
        
        view.addSubview(backgroundImage)
        backgroundImage.image = UIImage(named: "background")
        
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        
    }
    
    func configureTableView() {
        
        backgroundImage.addSubview(loveTableView)
        loveTableView.translatesAutoresizingMaskIntoConstraints = false
        loveTableView.frame           = view.bounds
        loveTableView.rowHeight       = 299
        loveTableView.delegate        = self
        loveTableView.dataSource      = self
        loveTableView.backgroundColor = .clear
        
        loveTableView.contentSize.width != loveTableView.bounds.size.width && loveTableView.contentSize.height != loveTableView.bounds.size.height
        
        loveTableView.register(LoveTableViewCell.self, forCellReuseIdentifier: LoveTableViewCell.loveReuseID)
        
        NSLayoutConstraint.activate([
            
            loveTableView.topAnchor.constraint(equalTo: backgroundImage.safeAreaLayoutGuide.topAnchor, constant: 10),
            loveTableView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            loveTableView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
            loveTableView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor)
            
        ])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resturant.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = loveTableView.dequeueReusableCell(withIdentifier: LoveTableViewCell.loveReuseID) as! LoveTableViewCell
        
        let item                      = resturant[indexPath.row]
        
        cell.configureImage(item)
        cell.backgroundColor          = .lightGray
        cell.cuisineLable.text        = "Cuisine"
        cell.deliveryTimeTitle.text   = "Delivery time"
        cell.ratingLable.text         = "Rating"
        cell.delegate                 = self
        return cell
        
    }
    

    

}

extension ViewController2: LoveRestaurantDelegate {
    func loveRestaurant(rest: Resturant) {
        //
    }
    
    func disLoveRestaurant(rest: Resturant) {
        if let row = resturant.firstIndex(where: { (restaurant) -> Bool in
            restaurant.id == rest.id
        }) {
            print("removing a restaurant from loved ...")
            resturant.remove(at: row)
            loveTableView.reloadData()
        }
    }
}
