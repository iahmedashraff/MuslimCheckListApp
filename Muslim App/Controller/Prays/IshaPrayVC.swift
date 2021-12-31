//
//  IshaPrayVC.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 01/11/2021.
//

import UIKit
import FirebaseAuth

class IshaPrayVC: UIViewController {
    var userDateInApp = NSDate()
    var screenName = "Isha"
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
        //send data
        //isha
        //Date()
        // Do any additional setup after loading the view.
    }
    

   
    // MARK: - IBActions

    @IBAction func sonaIshaPressed(_ sender: UIButton) {
        sender.setImage(UIImage(named: "Checkmark"), for: UIControl.State.normal)
        self.controller.updateFBRecord(key: "Sona_Isha") { [weak self] in
            guard let self = self else { return }
            self.controller.updateFBRecord(key: "Sona_Isha")
        }
        
    }
    
    @IBAction func ishaPressed(_ sender: UIButton) {
        sender.setImage(UIImage(named: "Checkmark"), for: UIControl.State.normal)

        self.controller.updateFBRecord(key: "Isha") { [weak self] in
            guard let self = self else { return }
            self.controller.updateFBRecord(key: "Isha")
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
 
        db.collection("App Users").document(userID).collection("Dates").document("\(dateString)").setData(["date": userDateInApp, "Screen Name": "\(screenName)"
       ]) { err in
           if let err = err {
               print("Error: \(err)")
           } else {
               print("Done")
                       }
                   }
    }

}
