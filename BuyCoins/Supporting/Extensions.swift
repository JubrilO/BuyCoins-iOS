//
//  Extensions.swift
//  BuyCoins
//
//  Created by Jubril on 22/05/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    @nonobjc class var bcGrey: UIColor {
        return UIColor(white: 197.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var bcPurple: UIColor {
        return UIColor(red: 150.0 / 255.0, green: 111.0 / 255.0, blue: 219.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var coolGrey: UIColor {
        return UIColor(red: 157.0 / 255.0, green: 157.0 / 255.0, blue: 163.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var bcLightGrey: UIColor {
        return UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 0.8)
    }
    
}

extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = .current
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        if floor(self) == self {
            numberFormatter.minimumFractionDigits = 0
        }
        else {
            numberFormatter.minimumFractionDigits = 2
        }
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.usesGroupingSeparator = true
        return numberFormatter.string(from: NSNumber(value:self))!
    }
    
    mutating func roundToPlaces(_ places : Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self.rounded() * divisor) / divisor
    }
    
    func formatPoints() -> String {
        var thousandNum = self / 1_000
        var millionNum = self / 1_000_000
        if  self >= 1_000 && self < 1_000_000 {
            if  floor(thousandNum) == thousandNum {
                return("\(Int(thousandNum))k")
            }
            return("\(thousandNum.roundToPlaces(2))k")
        }
        if  self > 1_000_000 {
            if  floor(millionNum) == millionNum {
                return "\(Int(thousandNum))k"
            }
            return "\(millionNum.roundToPlaces(2))M"
        }
        else{
            if  floor(self) == self {
                return "\(Int(self))"
            }
            return "\(self)"
        }
    }
}

extension String {

    static func cryptocurrency(_ cryptoCurrency: Cryptocurrency) -> String {
        var cryptoString = ""
        switch cryptoCurrency {
        case .bitcoinCash:
            cryptoString = "BCH"
        case .bitcoin:
            cryptoString = "BTC"
        case .ethereum:
            cryptoString = "ETH"
        case .litecoin:
            cryptoString = "LTC"
            
        default:
            break
        }
        return cryptoString
    }
}



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
    
    class var graphLabelFont: UIFont {
        return UIFont(name: "Graphik-Regular", size: 11.0)!
    }
    
    class func bcFontRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Graphik-Regular", size: size)!
    }
    
    class func bcFontMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Graphik-Medium", size: size)!
    }
    
    class func bcFontBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Graphik-Medium", size: size)!
    }
}

extension UIViewController {
    func displayErrorModal(error: String?, completionHandler: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Okay", style: .default, handler: completionHandler)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setupNavBarImage() {
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logoSmall"))
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}

@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
