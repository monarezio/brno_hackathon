//
//  PasswordField.swift
//  Smart Trash
//
//  Created by Samuel Kodytek on 08/12/2017.
//  Copyright © 2017 Samuel Kodytek. All rights reserved.
//

import UIKit

class PasswordField: TextField {

    var isValid: Bool = false
    
    override func setup() {
        super.setup()
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        addTarget(self, action: #selector(textFieldDidEnd(_:)), for: .editingDidEnd)
    }
    
    private func isValidPassword(testStr:String) -> Bool {
        return testStr.count >= 6
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = text {
            if (isValidPassword(testStr: text)) {
                textField.backgroundColor = UIColor.white
                isValid = true
                return
            }
        }
        isValid = false
    }
    
    @objc func textFieldDidEnd(_ textField: UITextField) {
        if let text = text {
            if (isValidPassword(testStr: text)) {
                textField.backgroundColor = UIColor.white
                isValid = true
                return
            }
        }
        
        isValid = false
        textField.backgroundColor = UIColor.red.lighter()
    }

}
