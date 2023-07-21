//
//  RegisterViewController.swift
//  Firebase chat Demo
//
//  Created by MohammedAlsudai on 17.07.2023.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var passwordTextFild: UITextField!
    
    @IBOutlet weak var emailTextFild: UITextField!
    
    override func viewDidLayoutSubviews() {
        
    }
  
    @IBAction func regesterPressed(_ sender: UIButton) {
                let email :String? = emailTextFild.text
                let password :String? = passwordTextFild.text
                if email != nil && password != nil {
                    Auth.auth().createUser(withEmail: email!, password: password!) { AuthDataResult,error in
                        if error != nil {
                            print(error?.localizedDescription)
                        } else {
                            self.performSegue(withIdentifier: K.regesterSegue, sender: self)
                        }
                    }
                }
        
    }
}
