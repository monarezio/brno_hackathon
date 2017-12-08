//
//  ViewController.swift
//  Smart Trash
//
//  Created by Samuel Kodytek on 08/12/2017.
//  Copyright © 2017 Samuel Kodytek. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func loginHandler(_ sender: Any) {
        LoginManager.sharedInstance.login(email: "trash@guided.cz", password: "hesloJeVeslo", success: {
            print("Logged in!")
        }) { (error) in
            print("Error \(error.localizedDescription)")
        }
    }
    
}

