//
//  DailyReportTViewCell.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 08/11/2021.
//

import UIKit
import FirebaseAuth

class DailyReportTViewCell: UITableViewCell {

    //MARK: -Outlets
    @IBOutlet weak var lblPray: UILabel!
    @IBOutlet weak var imgDone: UIImageView!
    @IBOutlet weak var lblRakaat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    //    syncDataWithPregress()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: -IBActions
    
    @IBAction func btnDonePressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
                    sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    
                }) { (success) in
                    UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
                        sender.isSelected = !sender.isSelected
                        sender.transform = .identity
                    }, completion: nil)
                }
          
            
        
            
        
    }
    
    //MARK: -HelperFunctions
//    btnDone.image = UIImage(named: "notdone")
//    btnDone.setImage((UIImage(named:"notdone"), for: .normal)
//    btnDone.setImage(UIImage(named:"Checkmark"), for: .selected)
//    btnDone.setImage(UIImage(named:"notdone"), for: .normal)
//    btnDone.setImage(UIImage(named:"Checkmark"), for: .selected)
//    func getDate() -> String {
//        let calender = Calendar.current
//        let components = calender.dateComponents([.year,.month,.day], from: Date())
//        let year = components.year
//        let month = components.month
//        let day = components.day
//        let dateString = String(year!) + "-" + String(month!) + "-" + String(day!)
//        return dateString
//    }
//    func syncDataWithPregress(){
//        guard let userID = Auth.auth().currentUser?.uid else {return}
//
//
//        let docRef = db.collection("App Users").document(userID).collection("Dates").document("\(getDate())")
//
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                //self.imgDone.image = UIImage(named: "notdone")
//
//            }else {
//                print("Document does not exist")
//            }
//        }
//    }
}
