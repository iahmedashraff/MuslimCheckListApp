//
//  ProgressNIB.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 14/12/2021.
//

import UIKit

@IBDesignable
class ProgressNIB: UIView{
    
    
    //MARK: -Constanse
    
    var text: String? {
       didSet {
           self.lblNumberOfThingsDone.text = text
           
       }
   }
//        var progresscolor: UIColor {
//            didSet{
//                self.progressBar.progressTintColor = progresscolor
//            }
//        }
//     
//        var backgroundProgresscolor: UIColor {
//            didSet{
//                self.progressBar.trackTintColor = backgroundProgresscolor
//    
//            }
//        }
    
    //MARK: -Outlets
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var lblNumberOfThingsDone: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    
    @IBOutlet weak var lblNumberOne: UILabel!
    
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
    
    //MARK: -HelperFunctions
    func commit(){
          Bundle.main.loadNibNamed("ProgressNIB", owner: self, options: nil)
          addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
       // setShadow = true
      }
}
