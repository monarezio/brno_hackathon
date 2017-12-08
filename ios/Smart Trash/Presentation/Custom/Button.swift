//
//  Button.swift
//  The Calculator
//
//  Created by Samuel Kodytek on 19/11/2017.
//  Copyright © 2017 Samuel Kodytek. All rights reserved.
//

import UIKit

@IBDesignable
class Button: UIButton {
    
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = radius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        addTarget(self, action: #selector(Button.pushButton(sender:)), for: .touchDown)
        addTarget(self, action: #selector(Button.inflateButton(sender:)), for: .touchUpInside)
        addTarget(self, action: #selector(Button.inflateButton(sender:)), for: .touchDragExit)
    }
    
    @objc func pushButton(sender:UIButton!) {
        
    }
    
    @objc func inflateButton(sender:UIButton!) {
        
    }
}
