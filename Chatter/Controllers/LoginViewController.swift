//
//  LoginViewController.swift
//  Chatter
//
//  Created by Nicholas Repaci on 10/14/20.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
    
    
}
