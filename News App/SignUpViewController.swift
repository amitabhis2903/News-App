//
//  SignUpViewController.swift
//  News App
//
//  Created by Ammy Pandey on 06/08/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var fullNameTxt: UITextField!
    @IBOutlet weak var userNametxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    
    @IBOutlet weak var profileImg: UIImageView!
    
    var imagePickerView = UIImagePickerController()
    var data: NSData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Mark: Delegate function to image picker view
        imagePickerView.delegate = self
        
        //Mark make uiimage circle form
        profileImg.layer.borderWidth = 1
        profileImg.layer.masksToBounds = false
        profileImg.layer.borderColor = UIColor.black.cgColor
        profileImg.layer.cornerRadius = profileImg.frame.height/2
        profileImg.clipsToBounds = true
       
    }
    //Mark: Image get function from gallary
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImg = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.profileImg.contentMode = .scaleToFill
            profileImg.image = pickedImg
            data = UIImagePNGRepresentation(profileImg.image!) as NSData?
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //Mark: Picked Image
    @IBAction func openImg(_ sender: UIButton) {
        imagePickerView.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePickerView.allowsEditing = false
        self.present(imagePickerView, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        
        let userData = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        let paswd = passwordTxt.text
        let confirmPaswd = confirmPasswordTxt.text
        if paswd != confirmPaswd {
            alertMsg(Message: "Password not match")
        }else {
            userData.setValue(fullNameTxt.text, forKey: "fullname")
            userData.setValue(userNametxt.text, forKey: "username")
            userData.setValue(emailTxt.text, forKey: "email")
            userData.setValue(passwordTxt.text, forKey: "password")
            userData.setValue(data, forKey: "image")
            
            do {
                
                try context.save()
                print("save data")
                 let viewController = self.storyboard!.instantiateViewController(withIdentifier: "Tab") as UIViewController
                self.present(viewController, animated: true, completion: nil)
                
            }catch {
                print("error")
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

    func alertMsg(Message: String){
        let alert = UIAlertController(title: "Alert Message", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
