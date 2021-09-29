//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Giovanna Rodrigues on 29/09/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

struct Constants{
    
    static let loginSegue = "LoginToChat"
    static let registerSegue = "RegisterToChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let appName = "⚡️FlashChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
