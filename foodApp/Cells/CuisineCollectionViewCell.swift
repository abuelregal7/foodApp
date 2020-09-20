//
//  CuisineCollectionViewCell.swift
//  foodApp
//
//  Created by Ahmed on 8/28/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class CuisineCollectionViewCell: UICollectionViewCell {
    
    let lable       = FDSecondaryTitleLable(textAlignment: .left, fontSize: 10, fontWeight: .regular, textColor: .systemRed)
    let radiousView = UIView()
    
    static let reuseID  = "CuisineCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureImage(_ home: Resturant?){
            
            guard let model = home else { return }
            
                
                self.lable.text = "\(model.genres!)"
            
        }
    
    
    private func configure() {
        addSubview(radiousView)
        radiousView.addSubview(lable)
        
        
        NSLayoutConstraint.activate([
            
            radiousView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            radiousView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            radiousView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            radiousView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            
            lable.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            lable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            lable.widthAnchor.constraint(equalToConstant: 56.16),
            lable.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        
    }
}
