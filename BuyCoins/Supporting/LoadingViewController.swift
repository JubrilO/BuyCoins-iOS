
//
//  LoadingViewController.swift
//  BuyCoins
//
//  Created by Jubril on 06/07/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewController: UIViewController {
    let activityIndicator = BCActivityIndicator(frame: CGRect(x: 0, y: 0, width: 71, height: 75))

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.coolGrey
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 75),
            activityIndicator.widthAnchor.constraint(equalToConstant: 71)
            ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.activityIndicator.startAnimating()
        }

    }
}

extension UIViewController {
    func add(_ child: UIViewController) {
            addChildViewController(child)
            child.view.frame = view.frame
            view.addSubview(child.view)
            child.didMove(toParentViewController: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
}
