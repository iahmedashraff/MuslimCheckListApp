//
//  AzkarVC.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 01/11/2021.
//

import UIKit
import FirebaseAuth
class MorningZekrVC: UIViewController {
    
    let screenName = "Moring"
    var userDateInApp = NSDate()
    var date = Date()
    var controller: PrayController = PrayController()

    //MARK:- OutLets
    
 
    @IBOutlet weak var footerView: UIView!{
        didSet{
            footerView.clipsToBounds = true
            footerView.layer.cornerRadius = 25
            footerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        }
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK:- IBActions
    
    @IBAction func donePressed(_ sender: UIButton) {
        sender.setImage(UIImage(named: "Checkmark"), for: UIControl.State.normal)

        self.controller.updateFBRecord(key: "Morning_Zekr") { [weak self] in
            guard let self = self else { return }
            self.controller.updateFBRecord(key: "Morning_Zekr")
        }
        
    }
    @IBAction func btnCancelPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK:- Helper Functions
    

}
