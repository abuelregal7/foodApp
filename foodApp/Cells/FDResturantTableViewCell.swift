//
//  FDResturantTableViewCell.swift
//  foodApp
//
//  Created by Ahmed on 8/25/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class FDResturantTableViewCell: UITableViewCell {

    let imageX = UIImageView()
    
    let contentViewCell = UIView()
    let containerFoodImage = UIView()
    let foodImage   = FDImageView(cornerRadius: 5)
    let containerStackView = UIView()
    
    static let reuseID  = "FavoriteCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
        addSubview(contentViewCell)
        contentViewCell.addSubview(containerFoodImage)
        containerFoodImage.addSubview(foodImage)
        foodImage.contentMode = .scaleAspectFill
        contentViewCell.addSubview(containerStackView)
        contentViewCell.translatesAutoresizingMaskIntoConstraints     = false
        containerFoodImage.translatesAutoresizingMaskIntoConstraints  = false
        foodImage.translatesAutoresizingMaskIntoConstraints           = false
        containerStackView.translatesAutoresizingMaskIntoConstraints  = false
        containerStackView.backgroundColor = .systemRed
        
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
            
            containerStackView.topAnchor.constraint(equalTo: containerFoodImage.bottomAnchor, constant: -20),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
        
    }
    
}
