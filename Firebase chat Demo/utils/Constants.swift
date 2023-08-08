//
//  Constants.swift
//  Firebase chat Demo
//
//  Created by MohammedAlsudai on 21.07.2023.
//

import Foundation

struct K {
    static let app_name = "⚡️FirebaseChat"
    static let loginSegue = "loginToChatScreen"
    static let regesterSegue = "regesterToChatScreen"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageTableViewCell"
    
    struct FStore {
        static let Messages_Collection = "messages"
        static let Sender = "sender"
        static let Body = "body"
        static let Date = "date"
    }
    
    struct BrnadColors {
        static let lightPurple = "BrandLightPurple"
        static let purple = "BrandPurple"
    }
}
