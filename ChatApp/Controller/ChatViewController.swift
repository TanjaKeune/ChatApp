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

    var messageArray : [Message] = [Message]()

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
        
//       set tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        tableView.addGestureRecognizer(tapGesture)
        tableView.register(UINib(nibName: "CustomMessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")

        configureTableView()

//        tableView.reloadData()
        retrieveMessages()

    }
    
    @objc func tableViewTapped() {
        
        messageTextfield.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        cell.messageBackground.layer.cornerRadius = 20
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named: "avatar2")
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }

    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 120.0
        
//        tableView.estimatedRowHeight = 120.0
    }

    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)

        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = FIRDatabase.database().reference().child("Messages")
        let messageDictionary = ["Sender": FIRAuth.auth()?.currentUser?.email, "MessageBody": messageTextfield.text!]
        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error, ref) in
            if error != nil {
                print(error)
            } else {
                print("Message saved!")
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            }
        }
        
        
        
    }
    
    //TODO: Create the retrieveMessages method here:
    
    func retrieveMessages() {
        let messageDB = FIRDatabase.database().reference().child("Messages")
        
        messageDB.observe(.childAdded) { (snapshot) in

            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            let newMessage = Message()
            newMessage.sender = sender
            newMessage.messageBody = text
            self.messageArray.append(newMessage)
            self.configureTableView()
            self.tableView.reloadData()
        }
        
        
    }
    
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
