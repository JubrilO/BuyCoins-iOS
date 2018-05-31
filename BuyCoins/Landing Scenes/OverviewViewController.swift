//
//  OverviewViewController.swift
//  BuyCoins
//
//  Created by Jubril on 5/29/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarImage()

    }
    
    func setupNavBarImage() {
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logoSmall"))
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

}
