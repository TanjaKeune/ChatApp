//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Tanja Keune on 9/28/17.
//  Copyright © 2017 SUGAPP. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func registerPressed(_ sender: AnyObject) {

        SVProgressHUD.show()
        disableUI()
//        check if the email is there and the passowrd
        
        if let email = emailTextfield.text {
            if let password = passwordTextfield.text {
                
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil {
                        SVProgressHUD.dismiss()
                        self.enableUI()
                        let errorPrint = (error?.localizedDescription)!
                        self.alertMessage(title: errorPrint, message: "Try again")
                    } else {
//                        success
                        SVProgressHUD.dismiss()
                        self.enableUI()
                        self.performSegue(withIdentifier: "goToChat", sender: self)
                    }
                })
            }
        } 
    }
    
    func alertMessage(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    func disableUI()
    {
        emailTextfield.isEnabled = false
        passwordTextfield.isEnabled = false
        registerButton.isEnabled = false
    }
    func enableUI()
    {
        emailTextfield.isEnabled = true
        passwordTextfield.isEnabled = true
        registerButton.isEnabled = true
    }
}
