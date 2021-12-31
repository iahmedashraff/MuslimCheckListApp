//
//  SettingNIB.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 23/11/2021.
//

import UIKit


@IBDesignable

class SettingNIB: UIView {
    
    //MARK: -Constase
    var text: String? {
       didSet {
           self.lblName.text = text
           
       }
   }
   
    var image: UIImage? {
        didSet{
            self.imageOutlet.image = image
        }
    }
    
//    var setShadow: Bool? = true {
//        didSet {
//            if setShadow ?? true {
//                backView.shadow()
//            }else {
//                backView.shadow(clear: true)
//
//            }
//        }
//    }
    

    
    
    //MARK: -Outlet
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backView: UIView!
       
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var lblName: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(frame: CGRect) {
            super.init(frame: frame)
            commit()
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commit()
        }
    
    
    
    
    //MARK: -Setup
    func commit(){
          Bundle.main.loadNibNamed("SettingNIB", owner: self, options: nil)
          addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
       // setShadow = true
      }
    
    
    
}
