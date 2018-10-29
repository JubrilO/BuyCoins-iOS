//
//  TradeHistoryViewController.swift
//  BuyCoins
//
//  Created by Jubril on 24/10/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit

class TradeHistoryViewController: UIViewController {
    @IBOutlet weak var segmentedControl: HBSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarImage()
        setupSegmentedControl()
        // Do any additional setup after loading the view.
    }
    
    func setupSegmentedControl() {
        segmentedControl.items = ["Pending", "Completed", "Failed"]
        segmentedControl.selectedLabelColor = .bcPurple
        segmentedControl.unselectedLabelColor = UIColor.white.withAlphaComponent(0.65)
        segmentedControl.borderColor = .clear
    }
    

}
