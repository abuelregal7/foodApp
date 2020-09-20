//
//  FDButton.swift
//  foodApp
//
//  Created by Ahmed on 8/28/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class FDButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String, cornerRadius: CGFloat, backgroundImage: UIImage, tintColor: UIColor){
        super.init(frame: .zero)
        self.backgroundColor                      = backgroundColor
        self.layer.cornerRadius                   = CGFloat(cornerRadius)
        self.tintColor                            = tintColor
        self.setTitle(title, for: .normal)
        self.setImage(backgroundImage, for: .normal)
        
        configure()
    }
    
    private func configure(){
        //layer.cornerRadius                        = 10
        //titleLabel?.textColor                     = .white
        setTitleColor(.white, for: .normal)
        titleLabel?.font                          = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor, title: String, cornerRadius: CGFloat, backgroundImage: UIImage, tintColor: UIColor) {
        
        self.backgroundColor                      = backgroundColor
        self.layer.cornerRadius                   = CGFloat(cornerRadius)
        self.tintColor                            = tintColor
        setTitle(title, for: .normal)
        self.setImage(backgroundImage, for: .normal)
        
        
    }

}
