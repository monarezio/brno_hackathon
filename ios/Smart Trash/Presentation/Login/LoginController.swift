//
//  ViewController.swift
//  Smart Trash
//
//  Created by Samuel Kodytek on 08/12/2017.
//  Copyright © 2017 Samuel Kodytek. All rights reserved.
//

import UIKit
import PopupDialog

class LoginController: UIViewController {
    
    @IBOutlet weak var emailField: EmailField!
    @IBOutlet weak var passwordField: PasswordField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.performSegue(withIdentifier: "mainMenu", sender: nil)
        
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func loginHandler(_ sender: Any) {
        if(emailField.isValid && passwordField.isValid) {
            LoginManager.sharedInstance.login(email: emailField.text!, password:passwordField.text!, success: {
                self.performSegue(withIdentifier: "mainMenu", sender: nil)
            }) { (error) in
                let popup = PopupDialog(title: "Error", message: "\(error.localizedDescription) 😔")
                let button = PopupDialogButton(title: "Ok", action: nil)
                popup.addButton(button)
                
                self.present(popup, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
}

