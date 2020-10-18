//
//  RegisterViewController.swift
//  Chatter
//
//  Created by Nicholas Repaci on 10/13/20.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    //need to give notificaton if password is less than 6 characters as it wont work
    //need notification if email is already in use
    //maybe verify email as well
    //MFA
    
    @IBAction func registerButton(_ sender: UIButton) {
        //if both email and password contain a string value, then create user
        //for reference, this is called optional chaining
        //don't want to unwrap because then a user can create users with a blank email and blank passwordn
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                //error is also an optional
                //future iteration: instead of printing error, relay error message from firebase to user via notification etc.
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    //added self because inside a closure
                    self.performSegue(withIdentifier: "registerToChat", sender: self)
                }
              // ...
            }
            
        }
        
        
    }
}
