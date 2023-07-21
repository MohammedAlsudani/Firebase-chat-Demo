//
//  ChatViewController.swift
//  Firebase chat Demo
//
//  Created by MohammedAlsudai on 17.07.2023.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.app_name
        navigationItem.hidesBackButton = true
    }
    
    
    @IBAction func onLogOutClicked(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError{
            print("Error singing out: %@", signOutError)
        }
    }
    
}
