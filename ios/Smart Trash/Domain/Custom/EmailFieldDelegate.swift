//
//  TextFieldDelegate.swift
//  Smart Trash
//
//  Created by Samuel Kodytek on 08/12/2017.
//  Copyright © 2017 Samuel Kodytek. All rights reserved.
//

import UIKit

class EmailFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(isValidEmail(testStr: textField.text!)) {
            textField.backgroundColor = UIColor.red.lighter()
        }
    }

    private func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
