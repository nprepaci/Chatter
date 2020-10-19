//
//  ChatViewController.swift
//  Chatter
//
//  Created by Nicholas Repaci on 10/14/20.
//

import Firebase
import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var logoutButtonPressed: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Message] = [Message(sender: "email3@gmail.com", body: "long message to test rounded corner dynamic piece abcd123 abcbcbcbcbcbcbcbcbcb 12312312312312312312312312 456456456456456456456"), Message(sender: "email99@gmail.com", body: "sup?"), Message(sender: "email14@gmail.com", body: "howdy"),]
    
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
