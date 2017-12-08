//
//  ViewController.swift
//  Smart Trash
//
//  Created by Samuel Kodytek on 08/12/2017.
//  Copyright © 2017 Samuel Kodytek. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var emailField: EmailField!
    @IBOutlet weak var passwordField: PasswordField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func loginHandler(_ sender: Any) {
        if(emailField.isValid && passwordField.isValid) {
            LoginManager.sharedInstance.login(email: emailField.text!, password:passwordField.text!, success: {
                print("Logged in!")
            }) { (error) in
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
}

