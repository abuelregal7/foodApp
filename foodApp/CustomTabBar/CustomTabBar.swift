//
//  CustomTabBar.swift
//  foodApp
//
//  Created by Ahmed on 6/19/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation
import UIKit
protocol CustomTabBarDelegate: class {
    func didPressOnButton(type: CustomTabBar.CustomTabBarButtons)
    func didPressOnCart()
}

class CustomTabBar: UIView {
    enum CustomTabBarButtons: Int {
        case home
        case loved
    }
    
    weak var delegate: CustomTabBarDelegate?
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var lineViewCenterX: NSLayoutConstraint!
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("It is working")
        commonInit()
    }
    
    func commonInit(){
        if let nibView = Bundle.main.loadNibNamed("CustomTabBar", owner: self, options: nil)?.first as? UIView{
            nibView.frame = self.bounds
            self.addSubview(nibView)
            containerView = nibView
        }
    }
    
    @IBAction func didPressOnHome(_ sender: UIButton) {
        print("Home")
        delegate?.didPressOnButton(type: .home)
        UIView.animate(withDuration: 0.4) {
            self.lineViewCenterX.constant = sender.frame.origin.x
            AnimationsFactory.animate(sender, animationType: .glow(from: 0.2))
            self.layoutIfNeeded()
        }
    }
    
    @IBAction func didPressOnLoved(_ sender: UIButton) {
        print("Loved")
        delegate?.didPressOnButton(type: .loved)
        UIView.animate(withDuration: 0.4) {
            self.lineViewCenterX.constant = sender.frame.origin.x
            AnimationsFactory.animate(sender, animationType: .glow(from: 0.2))
            self.layoutIfNeeded()
        }
    }
    
    @IBAction func didPressOnCart(_ sender: Any) {
        print("Cart")
        delegate?.didPressOnCart()
    }
}
