//
//  LoginManager.swift
//  Smart Trash
//
//  Created by Samuel Kodytek on 08/12/2017.
//  Copyright © 2017 Samuel Kodytek. All rights reserved.
//

import FirebaseAuth

class LoginManager: LoginProtocol {
    
    static let sharedInstance = LoginManager()
    
    private var user: User? = nil
    
    private init() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            self.user = user
        }
    }
    
    func login(email: String, password: String, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            self.user = user
            if let error = error {
                failure(error)
            } else {
                success()
            }
        }
    }
    
    func isLoggedIn() -> Bool {
        return (user != nil)
    }
    
    func getUser() -> User? {
        return user
    }
}
