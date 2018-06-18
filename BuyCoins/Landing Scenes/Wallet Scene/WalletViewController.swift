//
//  WalletViewController.swift
//  BuyCoins
//
//  Created by Jubril on 6/13/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit
import FSPagerView

class WalletViewController: UIViewController {
    
    @IBOutlet weak var pageControl: FSPageControl!
    @IBOutlet weak var cryptoTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            let walletPagerCell = UINib(nibName: Constants.CellIdentifiers.WalletPagerCell, bundle: nil)
            self.pagerView.register(walletPagerCell, forCellWithReuseIdentifier: Constants.CellIdentifiers.WalletPagerCell)
        }
    }
    
    
    var topSafeArea = CGFloat()
    var bottomSafeArea = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageControl()
        setupNavBarImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            topSafeArea = topLayoutGuide.length
            bottomSafeArea = bottomLayoutGuide.length
        }
    }
    
    @IBAction func onSegmentSelection(_ sender: UISegmentedControl) {
        pagerView.scrollToItem(at: sender.selectedSegmentIndex, animated: true)
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.setFillColor(UIColor.white, for: .selected)
        pageControl.setFillColor(UIColor.white.withAlphaComponent(0.4), for: .normal)
        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 8, height: 8)), for: .selected)
        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 8, height: 8)), for: .normal)

    }

}

extension WalletViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8 
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.WalletTransactionCell) as! WalletTransactionCell
        return cell
    }
}

extension WalletViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 4
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.WalletPagerCell, at: index) as! WalletPagerCell
        if cryptoTypeSegmentedControl != nil {
            cell.topConstraint.constant = cryptoTypeSegmentedControl.frame.origin.y + cryptoTypeSegmentedControl.bounds.height + 40 - topSafeArea
            view.layoutIfNeeded()
        }
        
        return cell
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        pageControl.currentPage = pagerView.currentIndex
        cryptoTypeSegmentedControl.selectedSegmentIndex = pagerView.currentIndex
    }
}
