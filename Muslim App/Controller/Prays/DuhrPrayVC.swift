//
//  duhrPrayVC.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 01/11/2021.
//

import UIKit
import FirebaseAuth

class DuhrPrayVC: UIViewController {
    var userDateInApp = NSDate()
    var screenName = "Duhr"
    var date = Date()
    var controller: PrayController = PrayController()
    @IBOutlet weak var footerView: UIView!{
        didSet{
            footerView.clipsToBounds = true
            footerView.layer.cornerRadius = 25
            footerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       // saveUserLog()
        // Do any additional setup after loading the view.
    }
    

   
    // MARK: - IBActions

    @IBAction func sonaDuhrPressed(_ sender: UIButton) {
        sender.setImage(UIImage(named: "Checkmark"), for: UIControl.State.normal)
        self.controller.updateFBRecord(key: "Sona_Duhr") { [weak self] in
            guard let self = self else { return }
            self.controller.updateFBRecord(key: "Sona_Duhr")
            
        }
        
    }
    
    @IBAction func DuhrPressed(_ sender: UIButton) {
        sender.setImage(UIImage(named: "Checkmark"), for: UIControl.State.normal)
        self.controller.updateFBRecord(key: "Duhr") { [weak self] in
            guard let self = self else { return }
            self.controller.updateFBRecord(key: "Duhr")
            
        }
        
    }
    @IBAction func btnCancelPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    
    func saveUserLog(){
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day], from: date)
        let year = components.year
        let month = components.month
        let day = components.day
        let dateString = String(year!) + "-" + String(month!) + "-" + String(day!)
        
        
       guard let userID = Auth.auth().currentUser?.uid else {return}
 
        db.collection("App Users").document(userID).collection("Dates").document("\(dateString)").setData(["date": userDateInApp, "Duhr": "\(screenName)"
       ]) { err in
           if let err = err {
               print("Error: \(err)")
           } else {
               print("Done")
                       }
                   }
    }

}
