//
//  EditUserInfoVC.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 25/11/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase
import FirebaseStorage


class EditUserInfoVC: UIViewController {
    
    //MARK: -Constance
    let userID = Auth.auth().currentUser!.uid
    let userEmail = Auth.auth().currentUser?.email
    let myAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Almarai-Regular", size: 16.0)!,.foregroundColor: UIColor(hexString: "#00C3C0"),.underlineStyle: NSUnderlineStyle.single.rawValue]
    let storage = Storage.storage().reference()

    //MARK: -Outlet
    
    @IBOutlet weak var btnUploadImage: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!{
        didSet{
            profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        }
    }
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    
    @IBOutlet weak var lblUpdateSucess: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        userProfileImage()
        setupUI()
        let attributeString = NSMutableAttributedString(
                string: "تحميل الصورة",
                attributes: myAttributes
             )
        btnUploadImage.setAttributedTitle(attributeString, for: .normal)
    }
   
    
    //MARK: -IBActions
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnUploadImagePressed(_ sender: UIButton) {
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    @IBAction func changePasswordPressed(_ sender: UIButton) {
        let changePasswordVC = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        
        changePasswordVC.modalPresentationStyle = .fullScreen
        present(changePasswordVC, animated: true, completion: nil)
    }
    @IBAction func updateDataPressed(_ sender: UIButton) {
        updateUserInfo()
    }
    
    //MARK: -Helper Functions
    func updateUserInfo(){
        guard let userID = Auth.auth().currentUser?.uid else {return}

        db.collection("App Users").document(userID).updateData([
            "Name": tfName.text!,
            "Email": tfEmail.text!,
            "Phone Number": tfPhone.text!
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                self.lblUpdateSucess.isHidden = false
                self.isValidEmail(self.tfEmail.text!)
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.tfName.text!
                Auth.auth().currentUser?.updateEmail(to: self.tfEmail.text!, completion: { error in
                    if error != nil{
                        print(error!.localizedDescription)
                        return
                }
                })
                
            }
        }
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
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func setupUI(){
        tfPhone.keyboardType = .phonePad
        tfEmail.keyboardType = .emailAddress
        tfName.font = UIFont.init(name: "Almarai-Regular", size: 17)
        tfEmail.font = UIFont.init(name: "Almarai-Regular", size: 17)
        tfPhone.font = UIFont.init(name: "Almarai-Regular", size: 17)
        
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
                let fullName = dataDescription?["Name"] as? String
                let email = dataDescription?["Email"] as? String
                let password = dataDescription?["Phone Number"] as? String
                
                self.tfName.text = "\(fullName ?? "")"
            
                self.tfEmail.text = "\(email ?? "")"
                self.tfPhone.text = "\(password ?? "")"
                    } else {
                        print("Document does not exist")
                    }
        }
    }
    func getUserInformation(){

        db.collection("App Users").whereField("UserId", isEqualTo: userID).addSnapshotListener { snap, error in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            for i in snap!.documentChanges{
                let userName = i.document.get("Name") as! String
                let userEmail = i.document.get("Email") as! String
                DispatchQueue.main.async {
                    self.tfName.text = "\(userName)"
                    self.tfName.text = "\(userEmail)"
                }
            }
        }
    }
}

extension EditUserInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage else {
            return
        }
        profileImageView.image = image

        guard let imageData = image.pngData() else{
          return
        }
        storage.child("users/\(userID)/profile.jpg").putData(imageData , metadata: nil, completion: { _, error in
            guard error == nil else{
                print("failed to upload")
                return
            }
            self.storage.child("users/\(self.userID)/profile.jpg").downloadURL { url, error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
                UserDefaults.standard.set(urlString, forKey: "url")
            }
            
        })
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
 
