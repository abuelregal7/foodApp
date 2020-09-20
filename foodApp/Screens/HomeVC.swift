//
//  HomeVC.swift
//  foodApp
//
//  Created by Ahmed on 8/31/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//


import UIKit
import Alamofire
import Kingfisher

class HomeVC: UIViewController {
    
    let backgroundImage          = UIImageView()
    let containerLocationView    = UIView()
    let rectImage                = UIImageView()
    let locationImage            = UIImageView()
    let locationLable            = FDSecondaryTitleLable(textAlignment: .left, fontSize: 20, fontWeight: .medium, textColor: .white)
    let containerCollectionView  = UIView()
    let containerTableView       = UIView()
    
    var Resturants: [Resturant]?
    var item: Resturant?
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
        getRest()
        
        fetchResturant { (response) in
            switch response {
            case .success(let resturant):
                guard let resturants = resturant else { return }
                for rest in resturants {
                    print("success")
                    print("rest: \(rest.price)")
                    
                }
            case .failure(_):
                print("Error")
            }
        }
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
    
    func getRest() {
        
        guard let url = URL(string: "http://i0sa.com/food/RestTypes") else { return }
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
            
                switch response.result {
                    
                case .success(let value):
                    
                    if let JSON = value as? Dictionary<String, AnyObject> {
                        
                        let status = JSON["data"] as! [[String : Any]]
                        
                        print("--------------------------")
                        print("status is : \(status)")
                        
                        for adic in status {
                            
                            let id = adic["id"] as! Int
                            print("id is : \(id)")
                            
                            let title = adic["title"] as! String
                            print("title is : \(title)")
                            
                            let image = adic["image"] as! String
                            print("image is : \(image)")
                            
                            let delivery_time = adic["delivery_time"] as! String
                            print("delivery_time is : \(delivery_time)")
                            
                            let rating = adic["rating"] as! Double
                            print("rating is : \(rating)")
                            
                            let rating_count = adic["rating_count"] as! Int
                            print("rating_count is : \(rating_count)")
                            
                            let genres = adic["genres"] as! [String]
                            print("genres is : \(genres)")
                            //liked
                            let liked = adic["liked"] as! Bool
                            print("liked is : \(liked)")
                            
                            print("--------------------------")
                            print("--------------------------")
                            
                            self.product.append(Resturant(
                                
                                id:              (adic["id"] as? Int)!,
                                title:           (adic["title"] as? String)!,
                                image:           (adic["image"] as? String)!,
                                delivery_time:   (adic["delivery_time"] as? String)!,
                                rating:          (adic["rating"] as? Double)!,
                                rating_count:    (adic["rating_count"] as? Int)!,
                                genres:          (adic["genres"] as? [String])!,
                                liked:           (adic["liked"] as? Bool)!
                                
                                ))
                        }
                        print("success")
                        
                        self.tableView.reloadData()
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
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
            containerCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            containerCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            containerCollectionView.heightAnchor.constraint(equalToConstant: 105)
            
        ])
        
    }
    func configureContainertableView() {
        
        containerTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerTableView)
        containerTableView.backgroundColor  = .clear
        containerTableView.alpha            = 0.97
        
        NSLayoutConstraint.activate([
            
            containerTableView.topAnchor.constraint(equalTo: containerCollectionView.bottomAnchor, constant: 15),
            containerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 35)
            
        ])
        
    }
    func configureTaleView() {
        
        containerTableView.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame           = containerTableView.bounds
        tableView.rowHeight       = 299
        tableView.delegate        = self
        tableView.dataSource      = self
        
        tableView.register(FDResturantTableViewCell.self, forCellReuseIdentifier: FDResturantTableViewCell.reuseID)
        
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: containerTableView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerTableView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: containerTableView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerTableView.bottomAnchor)
            
        ])
        
    }
    
    
    
    func fetchResturant(completion: @escaping (Result<[ResturantFood]?, NSError>) -> Void ) {
        
        let url = "http://i0sa.com/food/Rest"
        AF.request(url, method: .get, parameters: [:], headers: [:]).responseJSON { (response) in
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
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FDResturantTableViewCell.reuseID) as! FDResturantTableViewCell
        
        let item = self.product[indexPath.row]
        cell.configureImage(item)
        cell.backgroundColor = .lightGray
        cell.selectionStyle = .none
        cell.restTitleLable.textColor = .black
        //cell.loveButton.set(backgroundColor: .clear, title: "", cornerRadius: 0, backgroundImage: UIImage(named: "like")!, tintColor: .systemIndigo)
        //cell.loveButton.addTarget(self, action: #selector(LoveButtonPressed), for: .touchUpInside)
        cell.loveButton.contentMode   = .scaleToFill
        cell.cuisineLable.text        = "Cuisine"
        cell.viewForCollectionView.backgroundColor = .white
        cell.deliveryTimeTitle.text   = "Delivery time"
        cell.ratingLable.text         = "Rating"
        cell.delegate = self
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.Resturants?[indexPath.row]
        let view = self.storyboard?.instantiateViewController(withIdentifier: "ResturantViewController") as! ResturantVC
        view.data = item
        self.present(view, animated: true, completion: nil)
        
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

extension HomeVC: LoveRestaurantDelegate {
    
    func loveRestaurant(rest: Resturant) {
        if let row = product.firstIndex(where: { (restaurant) -> Bool in
            restaurant.id == rest.id
            }) {
            self.product[row].liked = true
            let indexPath = IndexPath(row: row, section: 0)
            tableView.reloadRows(at: [indexPath], with: .fade)
        } else {
            print("error love restaurant")
        }
    }
    
    func disLoveRestaurant(rest: Resturant) {
        if let row = product.firstIndex(where: { (restaurant) -> Bool in
            restaurant.id == rest.id
        }) {
            self.product[row].liked = false
            let indexPath = IndexPath(row: row, section: 0)
            tableView.reloadRows(at: [indexPath], with: .fade)
        } else {
            print("error dislove restaurant")
        }
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
