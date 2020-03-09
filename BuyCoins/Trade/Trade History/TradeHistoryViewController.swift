//
//  TradeHistoryViewController.swift
//  BuyCoins
//
//  Created by Jubril on 24/10/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit

class TradeHistoryViewController: UIViewController {
    var orderStatus = OrderStatus.pending
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: HBSegmentedControl!
    var orderData =  [OrdersQuery.Data.CurrentUser.Order.Edge.Node]() {
        didSet {
            
        }
    }
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
    
    
    func fetchOrders(status: OrderStatus) {
        let ordersQuery = OrdersQuery(status: status)
        apollo.fetch(query: ordersQuery) {
            result, error in
            if let error  = error {
                print(error.localizedDescription)
                self.displayErrorModal(error: error.localizedDescription)
            }
            guard let ordersData = result?.data else {print("Could not retreive wallet"); return}
            
            
            
        }
    }
}

extension TradeHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}
