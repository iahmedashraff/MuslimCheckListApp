//
//  PraysVC.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 01/11/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FajrPrayVC: UIViewController {
    var userDateInApp = NSDate()
    let screenName = "Fajr"
    var date = Date()
    var controller: PrayController = PrayController()
    //MARK:- Outlets
    @IBOutlet weak var btnSouna: UIButton!
    @IBOutlet weak var footerView: UIView!{
        didSet{
            footerView.clipsToBounds = true
            footerView.layer.cornerRadius = 25
            footerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        controller.updateFBRecord(key: "Fajr") { [weak self] in
//            guard let self = self else { return }
//            self.controller.updateFBRecord(key: "SonaFajr")
//       }
    }
    
    
    //MARK:- IBActions
    
    @IBAction func sonaFajrPressed(_ sender: UIButton) {
 
        sender.setImage(UIImage(named: "Checkmark"), for: UIControl.State.normal)
        self.controller.updateFBRecord(key: "SonaFajr") { [weak self] in
            guard let self = self else { return }
            self.controller.updateFBRecord(key: "SonaFajr")
            
        }
       
    }
    @IBAction func FajrPressed(_ sender: Any) {
        (sender as AnyObject).setImage(UIImage(named: "Checkmark"), for: UIControl.State.normal)
        self.controller.updateFBRecord(key: "Fajr") { [weak self] in
            guard let self = self else { return }
            self.controller.updateFBRecord(key: "Fajr")
            
        }
       
    }
    @IBAction func btnCancelPressed(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
    //MARK: -Helper Functions
    func getDate() {
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day], from: Date())
        let year = components.year
        let month = components.month
        let day = components.day
        let dateString = String(year!) + "-" + String(month!) + "-" + String(day!)
        }
}
