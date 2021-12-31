//
//  PasswordNIB.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 27/10/2021.
//

import UIKit


@IBDesignable

class PasswordNIB: UIView {
    
    
    //MARK: -Constance
    var passPlaceHolder: String? {
        didSet {
            self.lblPlaceHolder.text = passPlaceHolder
        }
    }
    
     var text: String? {
        didSet {
            self.tfPassword.text = text
            showPlaceHolder()
        }
    }
    
     var keyboardType: UIKeyboardType? {
        didSet {
            self.tfPassword.keyboardType = keyboardType ?? .default
        }
    }
    
     var isSecure: Bool? {
        didSet {
            self.tfPassword.isSecureTextEntry = true
        }
    }
    
    
    
    //MARK: -Outlets
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.layer.borderWidth = 1
            backView.layer.borderColor = UIColor.gray.cgColor
            backView.layer.backgroundColor = CGColor(red: 172, green: 177, blue: 176, alpha: 0.5)
            backView.layer.cornerRadius = 5
            
        }
    }
    
    @IBOutlet weak var lblPlaceHolder: UILabel!{
        didSet{
            self.lblPlaceHolder.isHidden = true
        }
    }
    
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var btnShowPassword: UIButton!
    
    
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
    
    //MARK: -IBActions
    @IBAction func changedTextFiledValue(_ sender: Any) {
        text = tfPassword.text
        showPlaceHolder()
    }
    @IBAction func showPassword(_ sender: Any) {
        tfPassword.isSecureTextEntry = !tfPassword.isSecureTextEntry
    }
    
    //MARK: -HelperFunctions
    func showPlaceHolder() {
        if (tfPassword.text?.isEmpty ?? true) == true {
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
          Bundle.main.loadNibNamed("PasswordNIB", owner: self, options: nil)
          addSubview(contentView)
          contentView.frame = self.bounds
          contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
      }
    
}

