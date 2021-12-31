//
//  ViewController.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 18/10/2021.
//

import UIKit

class StartNowVC: UIViewController {
    
    //MARK: -Outlets
    
    @IBOutlet weak var btnStartNowOutlet: UIButton!{
        didSet{
            btnStartNowOutlet.layer.cornerRadius = 30
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
        
    }
    //MARK: -IBActions
    
    
    @IBAction func btnStartNowPressed(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
    //MARK: -Helper Functions
    
    func getUserData(){
        
       UserDefaults.standard.integer(forKey: "User ID")
        
    }
}

