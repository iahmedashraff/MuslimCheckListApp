//
//  ChangePasswordVC.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 07/12/2021.
//

import UIKit
import FirebaseAuth

class ChangePasswordVC: UIViewController {

    //MARK: -Outlet
    @IBOutlet weak var tfOldPassword: PasswordNIB!
    
    @IBOutlet weak var tfNewPassword: PasswordNIB!
    
    @IBOutlet weak var btnDone: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: -IBActions
    
    @IBAction func forgetPasswordPressed(_ sender: UIButton) {
        let forgetPasswordVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
        forgetPasswordVC.modalPresentationStyle = .fullScreen
        self.present(forgetPasswordVC, animated: true, completion: nil)
    }
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func forgetPassword(_ sender: UIButton) {
        if  compeletfields() == true,
            (tfOldPassword.text?.isEmpty ?? true) != true,
            (tfNewPassword.text?.isEmpty ?? true) != true {
            
            Auth.auth().currentUser?.updatePassword(to: tfNewPassword.text!, completion: { error in
                if error != nil{
                    print(error!.localizedDescription)
                    return
                }else{
                    print("Sucess")
                }
            })
        
    }
    }
    
    
    //MARK: -HelperFunctions
    func compeletfields() -> Bool {
        var flag = true
        if (tfOldPassword.text?.isEmpty ?? true)  == true{
            tfOldPassword.lblPlaceHolder.isHidden = false
            tfOldPassword.lblPlaceHolder.text = "أدخل كلمة المرور الحالية"
            tfOldPassword.lblPlaceHolder.textColor = UIColor.red
            flag = false
        }else{
            tfOldPassword.lblPlaceHolder.isHidden = true
            tfOldPassword.lblPlaceHolder.text = ""

        }
        if (tfNewPassword.text?.isEmpty ?? true)  == true{
            tfNewPassword.lblPlaceHolder.isHidden = false
            tfNewPassword.lblPlaceHolder.text = "أدخل كلمة المرور الجديدة"
            tfNewPassword.lblPlaceHolder.textColor = UIColor.red
            flag = false
        }else{
            tfNewPassword.lblPlaceHolder.isHidden = true
            tfNewPassword.lblPlaceHolder.text = ""

        }
        return flag
    }
    
    
    func setupUI(){
        tfOldPassword.passPlaceHolder = "كلمة المرور الحالية"
        tfOldPassword.tfPassword.placeholder = "كلمة المرور الحالية"
        tfOldPassword.isSecure = true
        
        tfNewPassword.passPlaceHolder = "كلمة المرور الجديدة"
        tfNewPassword.tfPassword.placeholder = "كلمة المرور الجديدة"
        tfNewPassword.isSecure = true
    }

}

