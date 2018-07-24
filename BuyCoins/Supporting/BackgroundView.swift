//
//  BackgroundView.swift
//  BuyCoins
//
//  Created by Jubril on 24/07/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import UIKit

class BackgroundView: UIView {
    required init?(coder aDecoder: NSCoder) {   // 2 - storyboard initializer
        super.init(coder: aDecoder)
        fromNib()   // 5.
    }
    init() {   // 3 - programmatic initializer
        super.init(frame: CGRect.zero)  // 4.
        fromNib()  // 6.
    }
}
