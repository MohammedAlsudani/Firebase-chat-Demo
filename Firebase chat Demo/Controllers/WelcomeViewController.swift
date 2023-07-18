//
//  WelcomeViewController.swift
//  Firebase chat Demo
//
//  Created by MohammedAlsudai on 17.07.2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = "⚡️FirebaseChat"
        var charIndex = 0.0
        for letter in title {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
                self.titleLabel.text?.append(letter)
            }
            charIndex+=1
        }
    }

}
