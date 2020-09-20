//
//  FDResturantTableViewCell.swift
//  foodApp
//
//  Created by Ahmed on 8/25/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

protocol LoveRestaurantDelegate: class {
    func loveRestaurant(rest: Resturant)
    func disLoveRestaurant(rest: Resturant)
}

class FDResturantTableViewCell: UITableViewCell {

    let contentViewCell        = UIView()
    let containerFoodImage     = UIView()
    let foodImage              = FDImageView(cornerRadius: 5)
    let containerStackView     = UIView()
    
    let titleStack             = UIStackView()
    let restTitleLable         = FDSecondaryTitleLable(textAlignment: .natural, fontSize: 22, fontWeight: .bold, textColor: .black)
    let loveButton             = FDButton(backgroundColor: .clear, title: "", cornerRadius: 0, backgroundImage: UIImage(named: "like")!, tintColor: .systemIndigo)
    
    let lineView               = UIView()
    
    let stackViewone           = UIStackView()
    let cuisineLable           = FDSecondaryTitleLable(textAlignment: .left, fontSize: 17, fontWeight: .regular, textColor: .darkGray)
    let viewForCollectionView  = UIView()
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //If you set it false, you have to add constraints.
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(CuisineCollectionViewCell.self, forCellWithReuseIdentifier: CuisineCollectionViewCell.reuseID)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let lineViewOne            = UIView()
    
    let stackViewtwo           = UIStackView()
    let deliveryTimeTitle      = FDSecondaryTitleLable(textAlignment: .center, fontSize: 15, fontWeight: .regular, textColor: .darkGray)
    let delivertTime           = FDSecondaryTitleLable(textAlignment: .center, fontSize: 17, fontWeight: .regular, textColor: .darkGray)
    
    let lineViewTwo            = UIView()
    
    let stackViewThree         = UIStackView()
    let ratingLable            = FDSecondaryTitleLable(textAlignment: .natural, fontSize: 15, fontWeight: .regular, textColor: .darkGray)
    let stackViewFour          = UIStackView()
    let stackViewfive          = UIStackView()
    let ratingLableNumber      = FDSecondaryTitleLable(textAlignment: .center, fontSize: 13, fontWeight: .bold, textColor: .black)
    let starView               = UIView()
    let starImage               = UIImageView()
    let ratingCountLabel       = FDSecondaryTitleLable(textAlignment: .natural, fontSize: 13, fontWeight: .regular, textColor: .lightGray)
    
    static let reuseID         = "FavoriteCell"
    //static let reuseID2        = "FavoriteCell"
    
    var product = [Genres]()
    var genres = [String]()
    var item: Resturant?
    let genreFont = UIFont.systemFont(ofSize: 12, weight: .bold)
    
    weak var delegate: LoveRestaurantDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureStackView()
        styleLable()
        getRest()
        loveButton.addTarget(self, action: #selector(LoveButtonPressed), for: .touchUpInside)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func LoveButtonPressed() {
        
        print("click")
        
        if self.item?.liked ?? false {
            print("Trying to dislove a restaurant")
            delegate?.disLoveRestaurant(rest: self.item!)
            LovedManager.shared.removeItem(self.item)
        } else {
            print("Trying to love a restaurant")
            delegate?.loveRestaurant(rest: self.item!)
            LovedManager.shared.addItem(self.item)
        }
        
    }
    
    func configureImage(_ home: Resturant?){
    
    guard let model = home else { return }
    if let image = model.image {
        self.item = model
        self.foodImage.kf.indicatorType = .activity
        self.foodImage.kf.setImage(with: URL(string: image))
        self.restTitleLable.text        = model.title
        self.delivertTime.text          = model.delivery_time
        self.ratingLableNumber.text     = "\(model.rating!)"
        self.ratingCountLabel.text      = "\(model.rating_count!)"
        self.loveButton.imageView?.image = model.liked ?? false ?  #imageLiteral(resourceName: "liked") : #imageLiteral(resourceName: "like")

        //self.title.text = model.title
        
        genres = model.genres ?? []
        
        }
        //self.collectionView.reloadData()
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
                            
//                            let id = adic["id"] as! Int
//                            print("id is : \(id)")
//
//                            let title = adic["title"] as! String
//                            print("title is : \(title)")
//
//                            let image = adic["image"] as! String
//                            print("image is : \(image)")
//
//                            let delivery_time = adic["delivery_time"] as! String
//                            print("delivery_time is : \(delivery_time)")
//
//                            let rating = adic["rating"] as! Double
//                            print("rating is : \(rating)")
//
//                            let rating_count = adic["rating_count"] as! Int
//                            print("rating_count is : \(rating_count)")
                            
                            let genres = adic["genres"] as! [String]
                            print("genres is : \(genres)")
                            //liked
//                            let liked = adic["liked"] as! Bool
//                            print("liked is : \(liked)")
                            
                            print("--------------------------")
                            print("--------------------------")
                            
                            self.product.append(Genres(
                                
                                genres:          (adic["genres"] as? [String])!
                                
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

    
    
    
    private func styleLable() {
        
        restTitleLable.font  = UIFont.systemFont(ofSize: 22, weight: .bold)
        cuisineLable.font    = UIFont.systemFont(ofSize: 17, weight: .regular)
        cuisineLable.textColor = .darkGray
        deliveryTimeTitle.font    = UIFont.systemFont(ofSize: 17, weight: .regular)
        deliveryTimeTitle.textColor = .darkGray
        delivertTime.font    = UIFont.systemFont(ofSize: 17, weight: .regular)
        delivertTime.textColor = .black
        ratingLable.font    = UIFont.systemFont(ofSize: 17, weight: .regular)
        ratingLable.textColor = .darkGray
        ratingLableNumber.font    = UIFont.systemFont(ofSize: 17, weight: .regular)
        ratingLableNumber.textColor = .black
        ratingCountLabel.font    = UIFont.systemFont(ofSize: 17, weight: .regular)
        ratingCountLabel.textColor = .lightGray
        
    }
    
    
    private func configureStackView() {
        
        
        
        titleStack.axis           = .horizontal
        titleStack.distribution   = .fill
        
        titleStack.addArrangedSubview(restTitleLable)
        titleStack.addArrangedSubview(loveButton)
        
        stackViewone.axis         = .vertical
        stackViewone.distribution = .fill
        stackViewone.spacing      = 15
        
        stackViewone.addArrangedSubview(cuisineLable)
        stackViewone.addArrangedSubview(viewForCollectionView)
        
        stackViewtwo.axis         = .vertical
        stackViewtwo.distribution = .fill
        stackViewtwo.spacing      = 5
        
        stackViewtwo.addArrangedSubview(deliveryTimeTitle)
        stackViewtwo.addArrangedSubview(delivertTime)
        
        stackViewThree.axis         = .vertical
        stackViewThree.distribution = .fill
        stackViewThree.spacing      = 5
        
        stackViewThree.addArrangedSubview(ratingLable)
        stackViewThree.addArrangedSubview(stackViewFour)
        
        stackViewFour.axis         = .horizontal
        stackViewFour.distribution = .fill
        stackViewFour.spacing      = 13
        
        stackViewFour.addArrangedSubview(stackViewfive)
        stackViewFour.addArrangedSubview(ratingCountLabel)
        
        stackViewfive.axis         = .horizontal
        stackViewfive.distribution = .fill
        stackViewfive.spacing      = 5
        
        stackViewfive.addArrangedSubview(ratingLableNumber)
        stackViewfive.addArrangedSubview(starView)

    }
    
    
    func configure() {
        
        addSubview(contentViewCell)
        contentViewCell.layer.cornerRadius = 20
        //contentViewCell.backgroundColor = .lightGray
        //contentViewCell.layer.shadowColor = UIColor.lightGray.cgColor
        //collectionView.layer.shadowOpacity = 0.2
        contentViewCell.addSubview(containerFoodImage)
        containerFoodImage.addSubview(foodImage)
        containerFoodImage.backgroundColor = .clear
        foodImage.contentMode = .scaleAspectFill
        foodImage.layer.cornerRadius = 20
        contentViewCell.addSubview(containerStackView)
        containerStackView.backgroundColor = .white
        containerStackView.layer.cornerRadius = 20
        containerStackView.addSubview(titleStack)
        containerStackView.addSubview(lineView)
        lineView.backgroundColor = .lightGray
        containerStackView.addSubview(stackViewone)
        viewForCollectionView.addSubview(collectionView)
        collectionView.backgroundColor = .systemGray
        collectionView.layer.cornerRadius = 10
        containerStackView.addSubview(lineViewOne)
        lineViewOne.backgroundColor = .lightGray
        containerStackView.addSubview(stackViewtwo)
        containerStackView.addSubview(lineViewTwo)
        containerStackView.addSubview(stackViewThree)
        starView.addSubview(starImage)
        starImage.image = UIImage(named: "star")
        lineViewTwo.backgroundColor = .lightGray
        contentViewCell.translatesAutoresizingMaskIntoConstraints        = false
        containerFoodImage.translatesAutoresizingMaskIntoConstraints     = false
        foodImage.translatesAutoresizingMaskIntoConstraints              = false
        containerStackView.translatesAutoresizingMaskIntoConstraints     = false
        titleStack.translatesAutoresizingMaskIntoConstraints             = false
        lineView.translatesAutoresizingMaskIntoConstraints               = false
        stackViewone.translatesAutoresizingMaskIntoConstraints           = false
        lineViewOne.translatesAutoresizingMaskIntoConstraints            = false
        stackViewtwo.translatesAutoresizingMaskIntoConstraints           = false
        lineViewTwo .translatesAutoresizingMaskIntoConstraints           = false
        stackViewThree.translatesAutoresizingMaskIntoConstraints         = false
        ratingLable.translatesAutoresizingMaskIntoConstraints            = false
        stackViewFour.translatesAutoresizingMaskIntoConstraints          = false
        stackViewfive.translatesAutoresizingMaskIntoConstraints          = false
        ratingLableNumber.translatesAutoresizingMaskIntoConstraints      = false
        starView.translatesAutoresizingMaskIntoConstraints               = false
        starImage.translatesAutoresizingMaskIntoConstraints              = false
        ratingCountLabel.translatesAutoresizingMaskIntoConstraints       = false
        
        
        //containerStackView.backgroundColor = .systemRed
        
        //accessoryType         = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            
            contentViewCell.topAnchor.constraint(equalTo: topAnchor),
            contentViewCell.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentViewCell.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            containerFoodImage.topAnchor.constraint(equalTo: contentViewCell.topAnchor),
            containerFoodImage.leadingAnchor.constraint(equalTo: contentViewCell.leadingAnchor),
            containerFoodImage.trailingAnchor.constraint(equalTo: contentViewCell.trailingAnchor),
            containerFoodImage.heightAnchor.constraint(equalToConstant: 160),
            
            foodImage.topAnchor.constraint(equalTo: containerFoodImage.topAnchor),
            foodImage.leadingAnchor.constraint(equalTo: containerFoodImage.leadingAnchor),
            foodImage.trailingAnchor.constraint(equalTo: containerFoodImage.trailingAnchor),
            foodImage.bottomAnchor.constraint(equalTo: containerFoodImage.bottomAnchor),
            
            containerStackView.topAnchor.constraint(equalTo: containerFoodImage.bottomAnchor, constant: -26),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            titleStack.topAnchor.constraint(equalTo: containerStackView.topAnchor, constant: 3),
            titleStack.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor, constant: 10),
            titleStack.widthAnchor.constraint(equalToConstant: 392),
            titleStack.heightAnchor.constraint(equalToConstant: 22),
            
            lineView.topAnchor.constraint(equalTo: titleStack.bottomAnchor, constant: 5),
            lineView.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor, constant: 10),
            lineView.widthAnchor.constraint(equalToConstant: 392),
            lineView.heightAnchor.constraint(equalToConstant: 2),
            
            stackViewone.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            stackViewone.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor, constant: 5),
            stackViewone.widthAnchor.constraint(equalToConstant: 168.5),
            stackViewone.heightAnchor.constraint(equalToConstant: 75),
            
            lineViewOne.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 30),
            lineViewOne.leadingAnchor.constraint(equalTo: stackViewone.trailingAnchor, constant: 5),
            lineViewOne.widthAnchor.constraint(equalToConstant: 2),
            lineViewOne.heightAnchor.constraint(equalToConstant: 75),
            
            stackViewtwo.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            stackViewtwo.leadingAnchor.constraint(equalTo: lineViewOne.trailingAnchor, constant: 5),
            stackViewtwo.widthAnchor.constraint(equalToConstant: 91),
            stackViewtwo.heightAnchor.constraint(equalToConstant: 75),

            lineViewTwo.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 30),
            lineViewTwo.leadingAnchor.constraint(equalTo: stackViewtwo.trailingAnchor, constant: 5),
            lineViewTwo.widthAnchor.constraint(equalToConstant: 2),
            lineViewTwo.heightAnchor.constraint(equalToConstant: 75),
            
            stackViewThree.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            stackViewThree.leadingAnchor.constraint(equalTo: lineViewTwo.trailingAnchor, constant: 5),
            stackViewThree.widthAnchor.constraint(equalToConstant: 92),
            stackViewThree.heightAnchor.constraint(equalToConstant: 75),
            
            collectionView.topAnchor.constraint(equalTo: viewForCollectionView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: viewForCollectionView.leadingAnchor),
            //collectionView.widthAnchor.constraint(equalTo: viewForCollectionView.widthAnchor),
            //collectionView.heightAnchor.constraint(equalTo: viewForCollectionView.heightAnchor)
            collectionView.trailingAnchor.constraint(equalTo: viewForCollectionView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: viewForCollectionView.bottomAnchor)
            
        
        ])
        
    }
    
    
    
}

extension FDResturantTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return genres.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CuisineCollectionViewCell.reuseID, for: indexPath) as! CuisineCollectionViewCell
//        var genres = [String]()
//        var item: Resturant?
//        genres = item?.genres ?? []
        //let item = self.genres[indexPath.row]
        //cell.configureImage(item as? Resturant)
        //cell.lable.text = "\(product[indexPath.row].genres!)"
        cell.lable.text = "\(genres[indexPath.row])"
        
        cell.lable.textColor = .red
        //cell.lable.backgroundColor = .darkGray
        //cell.lable.layer.cornerRadius = 10
        //cell.radiousView.layer.cornerRadius = 15
        //cell.radiousView.backgroundColor = .darkGray
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.size.width, height: 40)
    }
    
}
