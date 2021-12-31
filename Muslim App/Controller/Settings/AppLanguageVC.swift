//
//  AppLanguageVC.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 30/11/2021.
//

import UIKit

class AppLanguageVC: UIViewController {

    // MARK: - Constase
    
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var btnArabicCheckMark: UIButton!
    
    @IBOutlet weak var btnEnglishheckMark: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    

    // MARK: - IBActions
    
    @IBAction func arabicCheckMarkPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
                    sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    
                }) { (success) in
                    UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
                        sender.isSelected = !sender.isSelected
                        sender.transform = .identity
                    }, completion: nil)
                }
    }
    
    
    @IBAction func englishCheckMarkPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
                    sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    
                }) { (success) in
                    UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
                        sender.isSelected = !sender.isSelected
                        sender.transform = .identity
                    }, completion: nil)
                }
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    // MARK: - Helper Functions
    func setupUI(){
        btnArabicCheckMark.setImage(UIImage(named:"notdone"), for: .normal)
        btnArabicCheckMark.setImage(UIImage(named:"Checkmark"), for: .selected)
        btnEnglishheckMark.setImage(UIImage(named:"notdone"), for: .normal)
        btnEnglishheckMark.setImage(UIImage(named:"Checkmark"), for: .selected)
    }
}
