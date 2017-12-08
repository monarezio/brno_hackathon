//
//  LoginProtocol.swift
//  Smart Trash
//
//  Created by Samuel Kodytek on 08/12/2017.
//  Copyright © 2017 Samuel Kodytek. All rights reserved.
//

import FirebaseAuth

protocol LoginProtocol {
    
    
    func login(email: String, password: String, success: @escaping () -> (), failure: @escaping (Error) -> ())
    
    func isLoggedIn() -> Bool
 
    func getUser() -> User?
}
