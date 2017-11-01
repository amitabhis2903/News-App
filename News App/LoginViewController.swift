//
//  LoginViewController.swift
//  News App
//
//  Created by Ammy Pandey on 06/08/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit
import CoreData
class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    var indicator = UIActivityIndicatorView()

    var userData = [Users]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.indicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        self.indicator.hidesWhenStopped = true

        // Do any additional setup after loading the view.
    }

    func checkUserDetails(user: String, passwd: String) -> Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let predicate = NSPredicate(format: "username = %@", user)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchRequest.predicate = predicate
        
        do {
            
            let fetchResult = try managedObjectContext.fetch(fetchRequest)
            
            if fetchResult.count>0{
                let objectEntity: Users = fetchResult.first as! Users
                userData = [objectEntity]
                if objectEntity.username == user && objectEntity.password == passwd {
                    return true
                }
                if objectEntity.username != user{
                    alertMsg(Message: "Invaild Username")
            }
                if password.text == "" {
                    alertMsg(Message: "Enter password")
                }else {
                    alertMsg(Message: "wrong password")
                    return false
                }
            
        }
            if userName.text == "" && password.text == ""{
                
                alertMsg(Message: "Please Fill The Detail")
                
            }
                
            else
            {
                alertMsg(Message: "Wrong UserName")
                return false
            }

            
           
    }
        catch {
            print("error")
        }
    return true
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
        self.indicator.startAnimating()
        if ((userName.text == "") || (password.text == "")) {
            checkUserDetails(user: userName.text!, passwd: password.text!)
        }
        else if ((userName.text != "") || (password.text != "")) {
            checkUserDetails(user: userName.text!, passwd: password.text!)
        }
         let viewController = self.storyboard!.instantiateViewController(withIdentifier: "Tab") as UIViewController
        self.present(viewController, animated: true, completion: nil)
        self.indicator.stopAnimating()
    }
   
    func alertMsg(Message: String){
        let alert = UIAlertController(title: "Alert Message", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
