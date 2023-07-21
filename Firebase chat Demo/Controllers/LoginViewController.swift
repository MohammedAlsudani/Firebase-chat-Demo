//
//  LoginViewController.swift
//  Firebase chat Demo
//
//  Created by MohammedAlsudai on 17.07.2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginPress(_ sender: UIButton) {
        if let email = emailTextField.text,let pass = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: pass) {  AuthDataResult,error in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
}
