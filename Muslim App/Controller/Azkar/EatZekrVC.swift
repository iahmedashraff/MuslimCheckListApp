//
//  AblutionZekrVC.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 14/12/2021.
//

import UIKit

class EatZekrVC: UIViewController {
    var controller: PrayController = PrayController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func donePressed(_ sender: UIButton) {
        sender.setImage(UIImage(named: "Checkmark"), for: UIControl.State.normal)

        self.controller.updateFBRecord(key: "Eat_Zekr") { [weak self] in
            guard let self = self else { return }
            self.controller.updateFBRecord(key: "Eat_Zekr")
        }
    
}
}
