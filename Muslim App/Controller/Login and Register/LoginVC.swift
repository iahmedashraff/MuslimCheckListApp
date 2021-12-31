//
//  LoginVC.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 18/10/2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FlagPhoneNumber


class LoginVC: UIViewController {
    //For show leak in Memory
    deinit {
        print("LoginVC deadloc")
    }
    
    //MARK: -Constanse
    
   


    
    // MARK: - Outlets
    @IBOutlet weak var tfPhoneNumber: TextFeildNIB!

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMassage: UILabel!
    @IBOutlet weak var tfPassword: PasswordNIB!
    
    @IBOutlet weak var btnLogin: UIButton!{
        didSet{
            btnLogin.layer.cornerRadius = 20
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setupUI()
    }
    
    // MARK: -IBActions
    
    
    @IBAction func forgetPasswordPressed(_ sender: UIButton) {
        
        let forgetPasswordVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
        forgetPasswordVC.modalPresentationStyle = .fullScreen
        self.present(forgetPasswordVC, animated: true, completion: nil)
    }
    @IBAction func btnBackPressed(_ sender: UIButton) {
        
        dismiss(animated: true)
    }

    @IBAction func btnLoginPressed(_ sender: UIButton) {
        if compeletfields() == true {
            db.collection("App Users").getDocuments { sucess, error in
                if error != nil {
                    
                    
                    print(error!.localizedDescription)
                    return
                }
                let email = self.tfPhoneNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = self.tfPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)

                Auth.auth().signIn(withEmail: email, password: password) { Result, error in
                    if error != nil{
                        self.errorMassage.isHidden = false
                        return
                    }else{
                        
                        let tabBarController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                        tabBarController.modalPresentationStyle = .fullScreen
                        self.present(tabBarController, animated: true, completion: nil)
                    }
                    
                }
              
            }
        }
        sender.isHidden = true
        indicator.isHidden = false
    }
    
    @IBAction func btnRegisterPressed(_ sender: Any) {
        
        let compeleteRegisterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CompeleteRegisterVC") as! CompeleteRegisterVC
        
        compeleteRegisterVC.modalPresentationStyle = .fullScreen

        self.present(compeleteRegisterVC, animated: true, completion: nil)
    }
    
    
    @IBAction func skipBtnPressed(_ sender: UIButton) {

        let tabBarController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true, completion: nil)
    }
    
    // MARK: - Helper Functions

    func setupUI(){
        
        tfPhoneNumber.placeHolder = "البريد الإلكتروني"
        tfPhoneNumber.keyboardType = .emailAddress
        tfPassword.passPlaceHolder = "كلمة المرور"
        
        tfPassword.isSecure = true
        
    }
  
    
    
    func compeletfields() -> Bool {
        var flag = true
        if (tfPhoneNumber.text?.isEmpty ?? true)  == true {
            tfPhoneNumber.lblPlaceHolder.isHidden = false
            tfPhoneNumber.lblPlaceHolder.text = "من فضلك أدخل بريدك الإلكترونى*"
            tfPhoneNumber.lblPlaceHolder.textColor = UIColor.red
            
            flag = false
        }else {
                tfPhoneNumber.lblPlaceHolder.isHidden = true
                tfPhoneNumber.lblPlaceHolder.text = ""
        }
        if (tfPassword.text?.isEmpty ?? true)  == true {
            tfPassword.lblPlaceHolder.isHidden = false
            tfPassword.lblPlaceHolder.text = "من فضلك أدخل كلمة المرور*"
            tfPassword.lblPlaceHolder.textColor = UIColor.red
            flag = false
        }else {
            tfPassword.lblPlaceHolder.isHidden = true
            tfPassword.lblPlaceHolder.text = ""
        }
        return flag
    }
    
    
        
}

