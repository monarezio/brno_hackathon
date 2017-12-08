//
//  EmailField.swift
//  Smart Trash
//
//  Created by Samuel Kodytek on 08/12/2017.
//  Copyright © 2017 Samuel Kodytek. All rights reserved.
//

import UIKit

class EmailField: TextField {
    
    var isValid: Bool = false
    
    override func setup() {
        super.setup()
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        addTarget(self, action: #selector(textFieldDidEnd(_:)), for: .editingDidEnd)
    }
    
     func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = text {
            if (isValidEmail(testStr: text)) {
                textField.backgroundColor = UIColor.white
                isValid = true
                return
            }
        }
        isValid = false
    }
    
    @objc func textFieldDidEnd(_ textField: UITextField) {
        if let text = text {
            if (isValidEmail(testStr: text)) {
                textField.backgroundColor = UIColor.white
                isValid = true
                return
            }
        }
        isValid = false
        textField.backgroundColor = UIColor.red.lighter()
    }
}
