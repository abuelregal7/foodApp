//
//  FDCollectionViewCircle.swift
//  foodApp
//
//  Created by Ahmed on 8/22/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class FDCollectionViewCircle: UICollectionViewCell {
    
    let image = FDImageView(cornerRadius: 25)
    let title = GFTitleLable(textAlignment: .center, fontZize: 14)
    
    static let reuseID  = "FollowerCell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImage(_ home: CircleModel?){
        
        guard let model = home else { return }
        if let image = model.image {
            self.image.kf.indicatorType = .activity
            self.image.kf.setImage(with: URL(string: image))
            self.title.text = model.title
        }
//        image.downloadImage(from: home.image!)
//        title.text = "\(home.title!)"
        
    }
    
    
    private func configure() {
        
        addSubview(image)
        addSubview(title)
        title.textColor = .white
        image.placeholderImage = UIImage(named: "18")
        
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 50),
            
            title.topAnchor.constraint(equalTo: image.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
            //title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            title.widthAnchor.constraint(equalToConstant: 60),
            title.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        
    }
    
}
