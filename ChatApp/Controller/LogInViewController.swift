//
//  LogInViewController.swift
//  ChatApp
//
//  Created by Tanja Keune on 9/28/17.
//  Copyright © 2017 SUGAPP. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logInPressed(_ sender: AnyObject) {

        SVProgressHUD.show()
        disableUI()
//        check for email enterd and password
        
        if let email = emailTextfield.text {
            if let password = passwordTextfield.text {
                
                FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                    
                    if error != nil {
                        self.enableUI()
                        print(error)
                    } else {
                        SVProgressHUD.dismiss()
                        self.enableUI()
                        self.performSegue(withIdentifier: "goToChat", sender: self)
                    }
                })
            }
        }
        
    }
    
    func disableUI()
    {
        emailTextfield.isEnabled = false
        passwordTextfield.isEnabled = false
        loginButton.isEnabled = false
    }
    func enableUI()
    {
        emailTextfield.isEnabled = true
        passwordTextfield.isEnabled = true
        loginButton.isEnabled = true
    }
}
