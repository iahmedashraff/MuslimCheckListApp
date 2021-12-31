//
//  MobileNumberNIB.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 20/10/2021.
//

import UIKit
import FlagPhoneNumber

@IBDesignable
class TextFeildNIB: UIView, UITextFieldDelegate {


    //MARK: -Outlet
   

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.layer.borderWidth = 1
            backView.layer.borderColor = UIColor.gray.cgColor
            backView.layer.backgroundColor = CGColor(red: 172, green: 177, blue: 176, alpha: 0.5)
            backView.layer.cornerRadius = 5
            
        }
    }
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    @IBOutlet weak var lblPlaceHolder: UILabel!{
        didSet{
            self.lblPlaceHolder.isHidden = true
        }
    }
    //MARK: -Constanse
    
    
    
    var placeHolder: String? {
        didSet {
            self.lblPlaceHolder.text = placeHolder
            self.txtPhoneNumber.placeholder = placeHolder
        }
    }

    var text: String? {
        didSet {
            self.txtPhoneNumber.text = text
            showPlaceHolder()
        }
    }

    var errorMessage: String? {
       didSet {
           self.txtPhoneNumber.text = errorMessage

           showErrorMessage()
       }
   }

    
    
     var keyboardType: UIKeyboardType? {
        didSet {
            self.txtPhoneNumber.keyboardType = keyboardType ?? .default

            
        }
    }
    
     var isSecure: Bool? {
        didSet {
            self.txtPhoneNumber.isSecureTextEntry = isSecure ?? false
        }
    }
    var isShowPhoneCountryCode: Bool?{
        didSet{
            self.txtPhoneNumber.isHidden = false

        }
    }
    var isTextHidden: Bool?{
        didSet{
            self.txtPhoneNumber.isHidden = true
        }
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        txtPhoneNumber.delegate = self

    }
    override init(frame: CGRect) {
            super.init(frame: frame)
            commit()
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commit()
        }
    
    //MARK: -IBActions

    
    @IBAction func changedTextFiledValueForText(_ sender: Any) {
        text = txtPhoneNumber.text
        showPlaceHolder()
    }
    
    
    //MARK: -Helper Functions
    func showErrorMessage() {
        if (txtPhoneNumber.text?.isEmpty ?? true) == true {
            isShowPlaceHolder(false);
        }else {
            isShowPlaceHolder(true);
        }
    }
    
    func showPlaceHolder() {
        if (txtPhoneNumber.text?.isEmpty ?? true)  == true {
            isShowPlaceHolder(false);
        }else {
            isShowPlaceHolder(true);
        }
    }
                // For Making Animation to placeholder
    func isShowPlaceHolder(_ isShow: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.lblPlaceHolder.isHidden = !isShow
        } completion: { com in
        }
    }

    //MARK: -Setup
    func commit(){
          Bundle.main.loadNibNamed("TextFeildNIB", owner: self, options: nil)
          addSubview(contentView)
          contentView.frame = self.bounds
          contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
      }
    
}
