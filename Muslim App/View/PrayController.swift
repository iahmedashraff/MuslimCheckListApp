//
//  PrayController.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 09/12/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class PrayController {

    func updateFBRecord(key: String, success: (()->())? = nil) {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        db.collection("App Users").document(userID).collection("Dates").document("\(getDate())").getDocument { document, error in
            if error != nil{
                print(error!.localizedDescription)
                return
    }
        if let document = document {
            let model = document.data()
            self.saveUserLog(obj: model ?? [:], key: key, success: success)
        }
        }
    }
    
    private func saveUserLog(obj: [String: Any], key: String, success: (()->())? = nil){
        var obj2 = obj
        obj2[key] = 1
        guard let userID = Auth.auth().currentUser?.uid else {return}
         db.collection("App Users").document(userID).collection("Dates").document("\(getDate())").setData(obj2) { err in
            if let err = err {
                print("Error: \(err)")
            } else {
                print("Done")
                success?()
                        }
                    }
    }
    
    func getDate() -> String {
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day], from: Date())
        let year = components.year
        let month = components.month
        let day = components.day
        let dateString = String(year!) + "-" + String(month!) + "-" + String(day!)
        return dateString
    }
}
