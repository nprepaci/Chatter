//
//  COnstants.swift
//  Chatter
//
//  Created by Nicholas Repaci on 10/18/20.
//

struct Constants {
    //static to make each property associated with the type Constants
    //if not static it would have to be generated via instances created from the type
    static let welcomeToRegisterSegue = "welcomeToRegister"
    static let welcomeToLoginSegue = "welcomeToLogin"
    static let registerToChatSegue = "registerToChat"
    static let loginToChatSegue = "loginToChat"
    
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
