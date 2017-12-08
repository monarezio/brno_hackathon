//
//  TextField.swift
//  Smart Trash
//
//  Created by Samuel Kodytek on 08/12/2017.
//  Copyright © 2017 Samuel Kodytek. All rights reserved.
//

import UIKit

@IBDesignable
class TextField: UITextField {
    @IBInspectable var borderRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = borderRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    open func setup() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
