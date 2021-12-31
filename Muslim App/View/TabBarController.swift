//
//  TabBarController.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 01/11/2021.
//

import UIKit

class TabBarController: UITabBarController {

    @IBOutlet weak var tBar: UITabBar!{
        didSet{
            tBar.layer.backgroundColor = UIColor.white.cgColor
            tBar.layer.shadowOffset = CGSize(width: 0, height: 0)
            tBar.layer.shadowRadius = 2
            tBar.layer.shadowColor = UIColor.black.cgColor
            tBar.layer.shadowOpacity = 0.3
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 0
        customizeAppearence()
        
    }
    
    func customizeAppearence() {
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        self.tabBar.itemPositioning = .centered
        self.tabBar.tintColor = UIColor(hexString: "#00C3C0")
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Almarai-Regular", size: 12)!], for: .normal)
      
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Almarai-Regular", size: 12)!], for: .selected)
        
        
        
    }
   

}
