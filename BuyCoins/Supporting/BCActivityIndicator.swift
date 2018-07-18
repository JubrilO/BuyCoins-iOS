//
//  BCActivityIndicator.swift
//  BuyCoins
//
//  Created by Jubril on 7/17/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import UIKit

class BCActivityIndicator: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addLogo(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var circle1 = UIView()
    var circle2 = UIView()
    
    func addLogo(frame: CGRect) {
        let circleWidth = frame.width * 61/71
        let circleHeight = frame.height * 61/75
        let x1 = frame.width - circleWidth
        let y1: CGFloat = 0
        let x2: CGFloat = 0
        let y2 = frame.height - circleHeight
        let circleRect1 = CGRect(x: x1, y: y1, width: circleWidth, height: circleHeight)
        let circleRect2 = CGRect(x: x2, y: y2, width: circleWidth, height: circleHeight)
        circle1 = UIView(frame: circleRect1)
        circle1.layer.cornerRadius = circleWidth/2
        circle1.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        circle2 = UIView(frame: circleRect2)
        circle2.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        circle2.layer.cornerRadius = circleWidth/2
        addSubview(circle1)
        addSubview(circle2)
    }
    
    func startAnimating() {
        UIView.animate(withDuration: 0.5, delay: 0,
                       options: [], animations: {
                        let xc1 = self.circle1.frame.origin.x
                        let yc1 = self.circle1.frame.origin.y
                        let xc2 = self.circle2.frame.origin.x
                        let yc2 = self.circle2.frame.origin.y
                        self.circle1.frame.origin.x = xc2
                        self.circle1.frame.origin.y = yc2
                        self.circle2.frame.origin.x = xc1
                        self.circle2.frame.origin.y = yc1
        }, completion:{ _ in self.startAnimating()})
    }
    
}

