//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Tanja Keune on 9/28/17.
//  Copyright © 2017 SUGAPP. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{

    
    // We've pre-linked the IBOutlets
//    @IBOutlet var heightConstraint: NSLayoutConstraint!


    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        messageTextfield.delegate = self
        
        tableView.register(UINib(nibName: "CustomMessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")

        configureTableView()

        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        let messageArray = ["First message", "Second Message", "Third Message"]
        cell.messageBackground.layer.cornerRadius = 20
        
        cell.messageBody.text = messageArray[indexPath.row]
        cell.avatarImageView.image = UIImage(named: "avatar")
        return cell
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 323
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 65
            self.view.layoutIfNeeded()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 120.0
//        tableView.estimatedRowHeight = 120.0
    }

    @IBAction func sendPressed(_ sender: AnyObject) {
        
        
        //TODO: Send the message to Firebase and save it in our database
        
        
    }
    
    //TODO: Create the retrieveMessages method here:
    
    @objc func logOut(){
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            print("error signing out")
        }
        guard (navigationController?.popToRootViewController(animated: true)) !=  nil
            else {
                print("No View Controllers to pop off")
                return
        }
    }
    

//    @IBAction func logOutPressed(_ sender: AnyObject) {
//
//        //TODO: Log out the user and send them back to WelcomeViewController
//
//
//    }
    

}
