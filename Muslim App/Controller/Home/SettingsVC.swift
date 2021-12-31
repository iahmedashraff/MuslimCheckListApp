//
//  SettingsVC.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 23/11/2021.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseMessaging
import FirebaseCore
import FirebaseStorage



class SettingsVC: UIViewController {
    
    //MARK: -Outlets
    
    @IBOutlet weak var profileImageView: UIImageView!{
        didSet{
            profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        }
    }
    @IBOutlet weak var swithNotifications: UISwitch!
    @IBOutlet weak var userBackView: UIView!{
        didSet{
            userBackView.layer.cornerRadius = 15
            userBackView.layer.shadowColor = UIColor.black.cgColor
            userBackView.layer.shadowOffset = CGSize(width: 0, height: 0)
            userBackView.layer.shadowOpacity = 0.1
            userBackView.layer.shadowRadius = 3.0
        }
    }
    
    @IBOutlet weak var userNameOutlet: UILabel!
    @IBOutlet weak var userEmailOutlet: UILabel!
    
    @IBOutlet weak var notifications: SettingNIB!
    @IBOutlet weak var viewNotification: UIView!{
        didSet{
            viewNotification.layer.cornerRadius = 15
            viewNotification.layer.shadowColor = UIColor.black.cgColor
            viewNotification.layer.shadowOffset = CGSize(width: 0, height: 0)
            viewNotification.layer.shadowOpacity = 0.1
            viewNotification.layer.shadowRadius = 3.0
        }
    }
    @IBOutlet weak var appLanguage: SettingNIB!
    @IBOutlet weak var viewAppLang: UIView!{
        didSet{
            viewAppLang.layer.cornerRadius = 15
            viewAppLang.layer.shadowColor = UIColor.black.cgColor
            viewAppLang.layer.shadowOffset = CGSize(width: 0, height: 0)
            viewAppLang.layer.shadowOpacity = 0.1
            viewAppLang.layer.shadowRadius = 3.0
        }
    }
    @IBOutlet weak var contactUs: SettingNIB!
    @IBOutlet weak var viewContactUS: UIView!{
        didSet{
            viewContactUS.layer.cornerRadius = 15
            viewContactUS.layer.shadowColor = UIColor.black.cgColor
            viewContactUS.layer.shadowOffset = CGSize(width: 0, height: 0)
            viewContactUS.layer.shadowOpacity = 0.1
            viewContactUS.layer.shadowRadius = 3.0
        }
    }
    
    @IBOutlet weak var backViewForAbout: UIView!{
        didSet{
            backViewForAbout.layer.cornerRadius = 15
            backViewForAbout.layer.shadowColor = UIColor.black.cgColor
            backViewForAbout.layer.shadowOffset = CGSize(width: 0, height: 0)
            backViewForAbout.layer.shadowOpacity = 0.1
            backViewForAbout.layer.shadowRadius = 3.0
        }
    }
    @IBOutlet weak var aboutApp: SettingNIB!
    @IBOutlet weak var shareApp: SettingNIB!
    @IBOutlet weak var logOut: SettingNIB!
    @IBOutlet weak var viewLogOut: UIView!{
        didSet{
            viewLogOut.layer.cornerRadius = 15
            viewLogOut.layer.shadowColor = UIColor.black.cgColor
            viewLogOut.layer.shadowOffset = CGSize(width: 0, height: 0)
            viewLogOut.layer.shadowOpacity = 0.1
            viewLogOut.layer.shadowRadius = 3.0
        }
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userProfileImage()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        gestureRecognizer()
       
    }
    

    //MARK: -IBActions
    
    @IBAction func switchChange(_ sender: UISwitch) {
        if sender.isOn{
           return
        }else{
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        }
    }
    @IBAction func btnEditUserInfoPressed(_ sender: UIButton) {
        let editUserInfoVC = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "EditUserInfoVC") as! EditUserInfoVC
        
        editUserInfoVC.modalPresentationStyle = .fullScreen
        present(editUserInfoVC, animated: true, completion: nil)
        
    }
    @IBAction func btnAppLanguage(_ sender: UIButton) {
        
        
    }
    
    @IBAction func btnContactUs(_ sender: UIButton) {
       
    }
    
    @IBAction func btnAboutUS(_ sender: UIButton) {
        let aboutUsVC = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
        
        aboutUsVC.modalPresentationStyle = .fullScreen
        present(aboutUsVC, animated: true, completion: nil)
    }
    
    @IBAction func btnShareApp(_ sender: UIButton) {
       
        let items = [URL(string: "https://www.apple.com")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(ac, animated: true)

    }
    //MARK: -Helper Functions
    func gestureRecognizer(){
        let logOutTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(logOutViewTapped(tapGestureRecognizer:)))
        viewLogOut.isUserInteractionEnabled = true
        viewLogOut.addGestureRecognizer(logOutTapGestureRecognizer)
        
        let AppLangTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(languageViewTapped(tapGestureRecognizer:)))
        viewAppLang.isUserInteractionEnabled = true
        viewAppLang.addGestureRecognizer(AppLangTapGestureRecognizer)
        
        let contactTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(languageViewTapped(tapGestureRecognizer:)))
        viewContactUS.isUserInteractionEnabled = true
        viewContactUS.addGestureRecognizer(contactTapGestureRecognizer)
        
        
        
    }
    @objc func logOutViewTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let startNowVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StartNowVC") as! StartNowVC
        startNowVC.modalPresentationStyle = .fullScreen
        
        guard let window = UIApplication.shared.keyWindow else {return
                }
                window.rootViewController?.dismiss(animated: false, completion: nil)
                window.rootViewController = startNowVC
                UIView.transition(with: window, duration: 0.7, options: [UIView.AnimationOptions.transitionFlipFromLeft], animations: {
                }, completion: {_ in})
    }
    
    @objc func languageViewTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let appLanguageVC = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "AppLanguageVC") as! AppLanguageVC
        
        appLanguageVC.modalPresentationStyle = .fullScreen
        present(appLanguageVC, animated: true, completion: nil)
    }
    @objc func contactViewTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let contactUsVC = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
        
        contactUsVC.modalPresentationStyle = .fullScreen
        present(contactUsVC, animated: true, completion: nil)
    }

    func userProfileImage(){
        
        guard let urlString =  UserDefaults.standard.string(forKey: "url") as? String,
         let url = URL(string: urlString)   else{
            return
        }

        
       let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.profileImageView.image = image
            }
        })
        task.resume()
    }

    func setupUI(){
        
        notifications.text = "الإشعارات"
        notifications.image = UIImage(named: "notifications")

        appLanguage.text = "لغة التطبيق"
        appLanguage.image = UIImage(named: "language")

        contactUs.text = "اتصل بنا"
        contactUs.image = UIImage(named: "contactus")

        aboutApp.text = "عن التطبيق"
        aboutApp.image = UIImage(named: "aboutUs")

        shareApp.text = "مشاركة التطبيق"
        shareApp.image = UIImage(named: "sharing")


        logOut.text = "تسجيل الخروج"
        logOut.image = UIImage(named: "logout")

        let currentUser = Auth.auth().currentUser
        let uid = currentUser?.uid
        
        let db = db.collection("App Users").document(uid!)
        
        db.getDocument { document, error in
                if error != nil{
                    print(error!.localizedDescription)
                    return
        }
            if let document = document, document.exists {
                let dataDescription = document.data()
                self.userNameOutlet.text = dataDescription?["Name"] as? String
                self.userEmailOutlet.text = dataDescription?["Email"] as? String
                    } else {
                        print("Document does not exist")
                    }
            
        
        
    }
    
    }
    
}
