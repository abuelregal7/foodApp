//
//  MainVC.swift
//  foodApp
//
//  Created by Ahmed on 6/19/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var tabBar: CustomTabBar!
    
    var homeVC: UIViewController!
    var favouritesVC: UIViewController!
    
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tabBar.delegate = self
        
        // creating VCs:
        homeVC = HomeVC()
        favouritesVC = LovedVC()
        viewControllers = [homeVC, favouritesVC]
        
        didPressOnButton(type: .home)

    }
    
}


extension MainVC: CustomTabBarDelegate {
func didPressOnButton(type: CustomTabBar.CustomTabBarButtons) {
    let previousIndex = selectedIndex
    selectedIndex = type.rawValue
    
    let previousVC = viewControllers[previousIndex]
    previousVC.willMove(toParent: nil)
    previousVC.view.removeFromSuperview()
    previousVC.removeFromParent()
    
    let vc = viewControllers[selectedIndex]
    addChild(vc)
    vc.view.frame = contentView.bounds
    contentView.addSubview(vc.view)
    vc.didMove(toParent: self)
}

func didPressOnCart() {
//    let cartVC = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as! CartVC
//    self.present(cartVC, animated: true)
    let cartVC = ViewController3()
    self.present(cartVC, animated: true)

    }
}
