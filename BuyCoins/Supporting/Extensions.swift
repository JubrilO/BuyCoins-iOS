//
//  Extensions.swift
//  BuyCoins
//
//  Created by Jubril on 22/05/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import UIKit


extension UIButton {
    
    @IBInspectable
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedTitle(for: .normal) {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            }
            else {
                attributedString = NSMutableAttributedString(string: self.titleLabel?.text ?? "")
                setTitle(.none, for: .normal)
            }
            
            attributedString.addAttribute(NSAttributedStringKey.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            
            setAttributedTitle(attributedString, for: .normal)
        }
        
        get {
            if let currentLetterSpace = attributedTitle(for: .normal)?.attribute(NSAttributedStringKey.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            }
            else {
                return 0
            }
        }
    }
}

extension UIFont {
    class var buttonFont: UIFont {
        return UIFont(name: "Graphik-Regular", size: 14.0)!
    }
    
    class var textFieldTitleFont: UIFont {
        return UIFont(name: "Graphik-Regular", size: 12.0)!
    }
}
