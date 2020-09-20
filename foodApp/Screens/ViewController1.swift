//
//  ViewController1.swift
//  foodApp
//
//  Created by Ahmed on 8/13/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
    
    let backgroundImage          = UIImageView()
    let containerLocationView    = UIView()
    let rectImage                = UIImageView()
    let locationImage            = UIImageView()
    let locationLable            = FDSecondaryTitleLable(textAlignment: .left, fontSize: 20, fontWeight: .medium)
    let containerCollectionView  = UIView()
    let containerTableView       = UIView()
    
    var product = [Resturant]()
    
    let tableView                = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor     = .systemBlue
        congigureBackgroundImage()
        configureLocationView()
        configurecontainerCollectionView()
        configureContainertableView()
        setAdd()
        configureTaleView()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
       //self.containerView.round(corners: [.bottomRight], radius: 450)
        self.containerTableView.round(corners: [.topRight, .topLeft], radius: 40)
       //self.roundedCorner.round(corners: [.topRight, .topLeft], radius: 187.5)
       //self.roundedCorner.round(corners: [.topRight, .topLeft], radius: 187.5)
       //self.roundedCorner.round(corners: [.topRight], radius: 200)
       //self.roundedCorner.round(corners: [.topRight, .bottomLeft], radius: 200)
       //self.roundedCorner.round(corners: [.topLeft, .bottomRight], radius: 200)
       
       
    
    }
    func setAdd() {
        
        //let collectionVC = FDContainerCollectionView()
        self.add(childVC: FDContainerCollectionView(), to: self.containerCollectionView)
        
    }
    
    
    func add(childVC: UIViewController, to ContainerView: UIView) {
        
        addChild(childVC)
        ContainerView.addSubview(childVC.view)
        childVC.view.frame = ContainerView.bounds
        childVC.didMove(toParent: self)
        
    }
    
    func congigureBackgroundImage() {
        
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
    func configureLocationView() {
        
        rectImage.image         = UIImage(named: "rectangle")
        locationImage.image     = UIImage(named: "location")
        locationLable.text      = "Naser City, Cairo"
        locationLable.textColor = .white
        
        //containerLocationView.backgroundColor = .systemRed
        
        containerLocationView.translatesAutoresizingMaskIntoConstraints  = false
        rectImage.translatesAutoresizingMaskIntoConstraints              = false
        locationImage.translatesAutoresizingMaskIntoConstraints          = false
        locationLable.translatesAutoresizingMaskIntoConstraints          = false
        
        view.addSubview(containerLocationView)
        containerLocationView.addSubview(rectImage)
        rectImage.addSubview(locationImage)
        rectImage.addSubview(locationLable)
        
        NSLayoutConstraint.activate([
            
            containerLocationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            containerLocationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            containerLocationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            containerLocationView.heightAnchor.constraint(equalToConstant: 70),
            
            rectImage.topAnchor.constraint(equalTo: containerLocationView.topAnchor, constant: 5),
            rectImage.leadingAnchor.constraint(equalTo: containerLocationView.leadingAnchor, constant: 10),
            rectImage.trailingAnchor.constraint(equalTo: containerLocationView.trailingAnchor, constant: -10),
            rectImage.bottomAnchor.constraint(equalTo: containerLocationView.bottomAnchor, constant: -5),
            
            locationImage.topAnchor.constraint(equalTo: rectImage.topAnchor, constant: 12),
            locationImage.leadingAnchor.constraint(equalTo: rectImage.leadingAnchor, constant: 40),
            locationImage.heightAnchor.constraint(equalToConstant: 40),
            locationImage.widthAnchor.constraint(equalToConstant: 30),
            
            locationLable.topAnchor.constraint(equalTo: rectImage.topAnchor, constant: 12),
            locationLable.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 10),
            locationLable.trailingAnchor.constraint(equalTo: rectImage.trailingAnchor, constant: 5),
            locationLable.heightAnchor.constraint(equalToConstant: 40)
            
            
        ])
    }
    
    func configurecontainerCollectionView() {
        
        containerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerCollectionView)
        
        NSLayoutConstraint.activate([
            
            containerCollectionView.topAnchor.constraint(equalTo: containerLocationView.bottomAnchor, constant: 2),
            containerCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            containerCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            containerCollectionView.heightAnchor.constraint(equalToConstant: 105)
            
        ])
        
    }
    func configureContainertableView() {
        
        containerTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerTableView)
        containerTableView.backgroundColor  = .lightGray
        containerTableView.alpha            = 0.75
        
        NSLayoutConstraint.activate([
            
            containerTableView.topAnchor.constraint(equalTo: containerCollectionView.bottomAnchor, constant: 7),
            containerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
    func configureTaleView() {
        
        containerTableView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame        = containerTableView.bounds
        tableView.rowHeight    = 299
        tableView.delegate     = self
        tableView.dataSource   = self
        
        tableView.register(FDResturantTableViewCell.self, forCellReuseIdentifier: FDResturantTableViewCell.reuseID)
        
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: containerTableView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerTableView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: containerTableView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerTableView.bottomAnchor)
            
        ])
        
    }
    

}

extension ViewController1: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FDResturantTableViewCell.reuseID) as! FDResturantTableViewCell
        cell.foodImage.image = UIImage(named: "18")
        return cell
    }
    
    
    
    
}

extension UIView {
    
    func round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path                  = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask                  = CAShapeLayer()
        mask.path                 = path.cgPath
        self.layer.mask           = mask
        self.layer.maskedCorners  = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        self.layer.masksToBounds  = true
        return mask
    }
    
}


