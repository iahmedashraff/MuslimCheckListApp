//
//  ForgetPasswordVC.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 07/12/2021.
//

import UIKit
import FirebaseAuth

class ForgetPasswordVC: UIViewController {

    
    //MARK: - Outlets
    @IBOutlet weak var lblDoneMessage: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var txtEmail: TextFeildNIB!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: -IBActions
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func btnContanuePressed(_ sender: UIButton) {
        if  compeletfields() == true,
            (txtEmail.text?.isEmpty ?? true) != true{
            
            Auth.auth().sendPasswordReset(withEmail: txtEmail.text!) { error in
                if error != nil{
                    print(error!.localizedDescription)
                    return
            }
                
                self.lblDoneMessage.isHidden = false
            }
            
        }else{
            print("Error")
        }
        sender.isHidden = true
        indicator.isHidden = false
    }
    
    
    //MARK: -HelperFunctions
    func compeletfields() -> Bool {
        var flag = true
        if (txtEmail.text?.isEmpty ?? true)  == true{
            txtEmail.lblPlaceHolder.isHidden = false
            txtEmail.lblPlaceHolder.text = "أدخل البريد الإلكتروني"
            txtEmail.lblPlaceHolder.textColor = UIColor.red
            flag = false
        }else{
            txtEmail.lblPlaceHolder.isHidden = true
            txtEmail.lblPlaceHolder.text = ""

        }
        return flag
    }
    
    func setupUI(){
        txtEmail.placeHolder = "البريد الإلكتروني"
        txtEmail.lblPlaceHolder.text = "البريد الإلكتروني"
        txtEmail.keyboardType = .emailAddress
    }
    
}
