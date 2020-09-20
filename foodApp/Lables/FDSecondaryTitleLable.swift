//
//  FDSecondaryTitleLable.swift
//  foodApp
//
//  Created by Ahmed on 8/22/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class FDSecondaryTitleLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment,fontSize: CGFloat, fontWeight: UIFont.Weight, textColor: UIColor){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.textColor     = textColor
        self.font          = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        //self.font = UIFont.systemFont(ofSize: fontZize, weight: .bold)
        configure()
    }
    
    private func configure() {
        
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
