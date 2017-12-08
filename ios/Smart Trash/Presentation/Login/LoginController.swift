//
//  ViewController.swift
//  Smart Trash
//
//  Created by Samuel Kodytek on 08/12/2017.
//  Copyright © 2017 Samuel Kodytek. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func loginHandler(_ sender: Any) {
        /*LoginManager.sharedInstance.login(email: emailField.text!, password:passwordField.text!, success: {
            print("Logged in!")
        }) { (error) in
            print("Error \(error.localizedDescription)")
        }*/
    }
    
}

