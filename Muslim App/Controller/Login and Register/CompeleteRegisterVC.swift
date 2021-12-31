//
//  CompeleteRegisterVC.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 27/10/2021.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class CompeleteRegisterVC: UIViewController {
    
    deinit {
        print("CompeleteRegisterVC deadloc")
    }

    
    let Date = NSDate()
    
    //MARK:- Outlets
    
    @IBOutlet weak var txtFirstName: TextFeildNIB!
    @IBOutlet weak var txtLastName: TextFeildNIB!
    @IBOutlet weak var txtEmail: TextFeildNIB!
    @IBOutlet weak var txtPhoneNumber: TextFeildNIB!
    @IBOutlet weak var txtPassword: PasswordNIB!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    

    //MARK:- IBActions
    
    @IBAction func btnCompleteRegisterPressed(_ sender: UIButton) {
  
        if  compeletfields() == true,
            (txtFirstName.text?.isEmpty ?? true) != true,
            (txtLastName.text?.isEmpty ?? true) != true,
            (txtEmail.text?.isEmpty ?? true) != true,
            (txtPhoneNumber.text?.isEmpty ?? true) != true,
            (txtPassword.text?.isEmpty ?? true) != true
        {
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { sucess, error in
                if error != nil{
                    print(error!.localizedDescription)
                    return
                }
                
                let tabBarController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                
                
                tabBarController.modalPresentationStyle = .fullScreen
                self.present(tabBarController, animated: true, completion: nil)
                
                guard let userID = sucess?.user.uid else {return}
                let space = " "
                db.collection("App Users").document(userID).setData([
                    "UserID": sucess!.user.uid,
                    "Name": self.txtFirstName.text! + space + self.txtLastName.text!,
                    "Email": self.txtEmail.text!,
                    "Phone Number": self.txtPhoneNumber.text!,
                    "Registration Date": self.Date
                    
                ]) { err in
                    if let err = err {
                        print("Error: \(err)")
                    } else {
                        
                    }
                }

                
            }
        }else{
            
            print("error")
        }
        sender.isHidden = true
        indicator.isHidden = false
    }
    @IBAction func btnLoginPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    //MARK:- Helper Functions
    func compeletfields() -> Bool {
        var flag = true
        if (txtFirstName.text?.isEmpty ?? true)  == true{
            txtFirstName.lblPlaceHolder.isHidden = false
            txtFirstName.lblPlaceHolder.text = "أدخل إسمك"
            txtFirstName.lblPlaceHolder.textColor = UIColor.red
            flag = false
        }else{
            txtFirstName.lblPlaceHolder.isHidden = true
            txtFirstName.lblPlaceHolder.text = ""

        }
        if(txtLastName.text?.isEmpty ?? true)  == true{
            txtLastName.lblPlaceHolder.isHidden = false
            txtLastName.lblPlaceHolder.text = "أدخل اسم العائلة"
            txtLastName.lblPlaceHolder.textColor = UIColor.red
            flag = false
        }else{
            txtLastName.lblPlaceHolder.isHidden = true
            txtLastName.lblPlaceHolder.text = ""
        }
        if (txtEmail.text?.isEmpty ?? true) == true{
            txtEmail.lblPlaceHolder.isHidden = false
            txtEmail.lblPlaceHolder.text = "أدخل بريدك الإلكتروني"
            txtEmail.lblPlaceHolder.textColor = UIColor.red
            flag = false
        }else{
            txtEmail.lblPlaceHolder.isHidden = true
            txtEmail.lblPlaceHolder.text = ""
        }
        if (txtPassword.text?.isEmpty ?? true) == true{
            txtPassword.lblPlaceHolder.isHidden = false
            txtPassword.lblPlaceHolder.text = "أدخل بريدك الإلكتروني"
            txtPassword.lblPlaceHolder.textColor = UIColor.red
            flag = false
        }else{
            txtPassword.lblPlaceHolder.isHidden = true
            txtPassword.lblPlaceHolder.text = ""
        }
        if (txtPhoneNumber.text?.isEmpty ?? true)  == true{
            txtPhoneNumber.lblPlaceHolder.isHidden = false
            txtPhoneNumber.lblPlaceHolder.text = "أدخل رقم هاتفك"
            txtPhoneNumber.lblPlaceHolder.textColor = UIColor.red
            flag = false
        }else{
            txtPhoneNumber.lblPlaceHolder.isHidden = true
            txtPhoneNumber.lblPlaceHolder.text = ""

        }
        
        return flag
    }
    
    func setupUI(){
        txtFirstName.placeHolder = "الإسم الأول"
        txtFirstName.lblPlaceHolder.text = "الإسم الأول"
        txtFirstName.keyboardType = .default
        
        txtLastName.placeHolder = "إسم العائلة"
        txtLastName.lblPlaceHolder.text = "إسم العائلة"
        
        txtEmail.placeHolder = "البريد الإلكتروني"
        txtEmail.lblPlaceHolder.text = "البريد الإلكتروني"
        
        txtPhoneNumber.placeHolder = "رقم الهاتف"
        txtPhoneNumber.lblPlaceHolder.text = "رقم الهاتف"
        txtPhoneNumber.keyboardType = .phonePad
        
        txtPassword.passPlaceHolder = "كلمة المرور"
        txtPassword.isSecure = true
        
        txtEmail.keyboardType = .emailAddress
        
        

    }
    func getDate() -> String {
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day], from: Foundation.Date())
        let year = components.year
        let month = components.month
        let day = components.day
        let dateString = String(year!) + "-" + String(month!) + "-" + String(day!)
        return dateString
    }
}
