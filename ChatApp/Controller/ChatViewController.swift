//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Tanja Keune on 9/28/17.
//  Copyright © 2017 SUGAPP. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    
    // We've pre-linked the IBOutlets
//    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        
        //TODO: Send the message to Firebase and save it in our database
        
        
    }
    
    //TODO: Create the retrieveMessages method here:
    
    @objc func logOut(){
        print("Log out pressed")
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            print("error signing out")
        }
    }
    

//    @IBAction func logOutPressed(_ sender: AnyObject) {
//
//        //TODO: Log out the user and send them back to WelcomeViewController
//
//
//    }
    

}
