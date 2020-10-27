//
//  ChatViewController.swift
//  Chatter
//
//  Created by Nicholas Repaci on 10/14/20.
//

import Firebase
import UIKit

class ChatViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var logoutButtonPressed: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    
    var messages: [Message] = [Message(sender: "email3@gmail.com", body: "test")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set as self so it looks for appropriate delegates in the code, in this case the extension of chat view controller at the bottom of the page
        //tableView.delegate = self
        tableView.dataSource = self
        
        //accesses messagecell classes
        //to use constants.cellidentifier, needed to rename the cell in messagecell.xib to ReusableCell
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        //hides back button
        navigationItem.hidesBackButton = true
        navigationItem.title = "Messages"
        
        loadMessages()
    }
    
    
    //gets new messages and appends to messages array - which then displays in the table view
    func loadMessages() {
        
        //added order by date to order by date parameter passed to firebade in sendPressed - this will allow for messages to be sorted in ascending order
        //added snapshotlistener in db.collections instead of just grabbing documents
        //snapshot listener is a listener to activey reload as necessary
        db.collection(Constants.FStore.collectionName).order(by: Constants.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
            
            //emptying messages array inside closue so it does not return duplicate messages
            self.messages = []
            
            if let e = error {
                print("there was an issue retrieving data from Firestore. \(e)")
                
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[Constants.FStore.senderField] as? String, let messageBody = data[Constants.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            
                            self.messages.append(newMessage)
                            
                            //reloads the tableview to display any new messages once load messages fuction completes
                            //necessary due to message time variance based on internet connection speed
                            //since this is happening in a closue, which means it is happening in the background, calling the main thread once funciton is completed
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: Any) {
        
        //if message text field is not nil and message sender email is not nil, then save in each of the constants, then run if statement
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.senderField: messageSender,
                Constants.FStore.bodyField: messageBody,
                Constants.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("successfully saved data")
                }
            }
            
        }
    }
    
    
    
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        print("Signed out successfully!")
        //navigation controller allows you to circumvent segue and utilize pop to root
        navigationController?.popToRootViewController(animated: true)
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
      
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    //function below gets called for each number in the count above messages.count
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell //casted as messagecell class
        
        //returns the body of the message for each row (indexpath.row returns the number ocrresponding to each row i.e. 1, 2, 3)
        //the label in cell.label is found in the messagecell.swift class, able to access this because I casted the cell above as type messageCell (aka the messagecell.swift file)
        //due to this no longer needed the prototype cell in the tableview
        cell.label.text = messages[indexPath.row].body
        return cell
    }
    
     
}

//deals with user interaction with rows in the table
//commenting out for use later
//extension ChatViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
//}
