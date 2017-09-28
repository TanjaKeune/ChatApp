//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Tanja Keune on 9/28/17.
//  Copyright © 2017 SUGAPP. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    // We've pre-linked the IBOutlets
//    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Test"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
