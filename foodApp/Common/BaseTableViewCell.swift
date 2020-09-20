//
//  BaseTableViewCell.swift
//  foodApp
//
//  Created by Ahmed on 6/19/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure<T>(_ item: T?){
        guard let _ = item else { return }
    }

}
