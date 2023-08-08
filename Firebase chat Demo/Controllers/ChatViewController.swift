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
    
    let db = Firestore.firestore()
    
    var messages:[Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.app_name
        navigationItem.hidesBackButton = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
    }

    func loadMessages(){
        db.collection(K.FStore.Messages_Collection).order(by: K.FStore.Date).addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            if let e = error{
              print("There was an issue loading the data.")
            } else {
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let messageSender = data[K.FStore.Sender] as? String, let messageBody = data[K.FStore.Body] as? String {
                            self.messages.append(Message(sender: messageSender, body:messageBody))
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }

    @IBAction func onSendMessage(_ sender: UIButton) {
        if let messageBody = messageTextField.text,
           let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.Messages_Collection).addDocument(data: [K.FStore.Sender:messageSender,K.FStore.Body: messageBody, K.FStore.Date: Date().timeIntervalSince1970]){(error) in
                if let e = error{
                    print("There was an issue saving datae to firestore, \(e)")
                } else {
                    print("successfully saved data.")
                    self.messageTextField.text = ""
                }
            }

        }
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

extension ChatViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageTableViewCell
        let message = messages[indexPath.row]
        
        cell.label?.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrnadColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrnadColors.purple)
        }else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrnadColors.purple)
            cell.label.textColor = UIColor(named: K.BrnadColors.lightPurple)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
