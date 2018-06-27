//
//  BCBorderedTextField.swift
//  BuyCoins
//
//  Created by Jubril on 6/25/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit

class BCBorderedTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.coolGrey.withAlphaComponent(0.5).cgColor
    }
    
    let padding = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 52);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        self.layer.borderColor = UIColor.bcPurple.cgColor
        self.layer.borderWidth = 1.0
        return result
    }
    
    override func resignFirstResponder() -> Bool {
         let result = super.resignFirstResponder()
        self.layer.borderColor = UIColor.coolGrey.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 1.0
        return result
    }
    
    func updateBorderColor() {
        
    }

    
    fileprivate func newBounds(_ bounds: CGRect) -> CGRect {
        
        var newBounds = bounds
        newBounds.origin.x += padding.left
        newBounds.origin.y += padding.top
        newBounds.size.height -= padding.top + padding.bottom
        newBounds.size.width -= padding.left + padding.right
        return newBounds
    }
    
    

}
