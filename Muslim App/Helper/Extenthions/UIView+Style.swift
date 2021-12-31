//
//  UIView+Style.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 25/11/2021.
//

import Foundation
import UIKit

extension UIView {
    
    func shadow(clear: Bool = false){
        if clear {
            self.layer.cornerRadius = 0
            self.layer.shadowColor = UIColor.white.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.layer.shadowOpacity = 0
            self.layer.shadowRadius = 0
            
        }else{
            self.layer.cornerRadius = 15
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.layer.shadowOpacity = 0.1
            self.layer.shadowRadius = 3.0
        }
       
    }
    
    
}
